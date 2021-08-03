//
//  TradeService.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 28.07.2021.
//

import GRPC
import NIO

protocol AnyTradeService {
    func subscribeOperation(
        object: AnyObject,
        callOptions: CallOptions,
        completion: @escaping (Result<INVTradingOrder?, INVError>) -> Void)
    func subscribeWatchSingle(
        object: AnyObject,
        request: INVTradingWatchRequest,
        callOptions: CallOptions,
        completion: @escaping (Result<INVTradingWatchPrice?, INVError>) -> Void)
    func send(_ operation: INVTradingOperation)
    func hideOrder(
        ids: [Int],
        completion: @escaping (INVError?) -> Void)
    func unsubscribe(
        object: AnyObject,
        from streamType: INVStreamType)
    func stopStreams()
}

final class TradeService: AnyService {
    typealias ServiceClient = Ru_Mts_Trading_Trade_TradingClient
    
    // MARK: Private properties
    private var eventLoopGroup: EventLoopGroup?
    private var service: ServiceClient?
    private var channel: ClientConnection?
    private var callOptions: CallOptions?
    private var (host, port): (String, Int)
    
    private var tradeOperationObservers: Observable<INVTradingOrder>
    private var operationStream: BidirectionalStreamingCall<
        Ru_Mts_Trading_Trade_TradingOperation,
        Ru_Mts_Trading_Trade_Order>?
    
    private var watchSinglePriceObservers: Observable<INVTradingWatchPrice>
    private var watchSingleStream: ServerStreamingCall<
        Ru_Mts_Trading_Trade_WatchRequest,
        Ru_Mts_Trading_Trade_WatchPrice>?
    
    
    // MARK: Lifecycle
    init(
        host: String,
        port: Int) {
        (self.host, self.port) = (host, port)
        tradeOperationObservers = .init(streamType: .tradeOperation)
        watchSinglePriceObservers = .init(streamType: .watchSingle)
        tradeOperationObservers.delegate = self
        watchSinglePriceObservers.delegate = self
        configureService()
    }
    
    deinit {
        stopStreams()
    }
    
    // MARK: Private methods
    private func configureService() {
        eventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        channel = ClientConnection
            .usingPlatformAppropriateTLS(for: eventLoopGroup!)
            .connect(
                host: host,
                port: port)
        guard let channel = channel else { return }
        service = ServiceClient(channel: channel)
    }
    
    // MARK: Operation
    private func operationsStreamConnect() {
        guard let service = service else { return }
        DispatchQueue.global().async {
            self.operationStream = service.operation(callOptions: self.callOptions) { [weak self] tradingOrder in
                self?.tradeOperationObservers.onNext(INVTradingOrder(from: tradingOrder))
            }
            
            self.operationStream?.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                switch error {
                case .unavailable:
                    self.configureService()
                default:
                    self.tradeOperationObservers.onError(error)
                }
            }
        }
    }
    
    private func operationsStreamClose() {
        operationStream?.sendEnd(promise: nil)
    }
    
    // MARK: Watch single price
    private func watchSingleStreamConnect(request: INVTradingWatchRequest) {
        guard let service = service else { return }
        DispatchQueue.global().async {
            self.watchSingleStream = service.watchSingle(
                request.grpcModel(),
                callOptions: self.callOptions) { [weak self] tradePrice in
                self?.watchSinglePriceObservers.onNext(INVTradingWatchPrice(from: tradePrice))
            }
            
            self.watchSingleStream?.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                switch error {
                case .unavailable:
                    self.configureService()
                default:
                    self.watchSinglePriceObservers.onError(error)
                }
            }
        }
    }
    
    private func watchSingleStreamClose() {
        watchSingleStream?.cancel(promise: nil)
    }
    
    // MARK: Hide orders
    private func hideOrders(
        orderIDs: [Int],
        completion: @escaping (INVError?) -> Void) {
        guard let service = service else { return }
        DispatchQueue.global().async {
            let orderIDs = orderIDs.map { UInt64($0) }
            let request = Ru_Mts_Trading_Trade_HideRequest
                .with {
                    $0.orderIds = orderIDs
                }
            let call = service.hide(
                request,
                callOptions: self.callOptions)
            do {
                _ = try call.response.wait()
                completion(nil)
            } catch {
                completion(INVError(from: error.localizedDescription))
            }
            
            call.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                completion(error)
            }
        }
    }
}
// MARK: - AnyTradeService
extension TradeService: AnyTradeService {
    func subscribeOperation(
        object: AnyObject,
        callOptions: CallOptions,
        completion: @escaping (Result<INVTradingOrder?, INVError>) -> Void) {
        self.callOptions = callOptions
        tradeOperationObservers.subscribe(
            object,
            event: completion)
        operationsStreamConnect()
    }
    
    func subscribeWatchSingle(
        object: AnyObject,
        request: INVTradingWatchRequest,
        callOptions: CallOptions,
        completion: @escaping (Result<INVTradingWatchPrice?, INVError>) -> Void) {
        self.callOptions = callOptions
        watchSinglePriceObservers.subscribe(
            object,
            event: completion)
        watchSingleStreamConnect(request: request)
    }
    
    func send(_ operation: INVTradingOperation) {
        operationStream?.sendMessage(
            operation.grpcModel(),
            promise: nil)
    }
    
    func hideOrder(
        ids: [Int],
        completion: @escaping (INVError?) -> Void) {
        hideOrders(orderIDs: ids, completion: completion)
    }
    
    func unsubscribe(
        object: AnyObject,
        from streamType: INVStreamType) {
        switch streamType {
        case .tradeOperation:
            tradeOperationObservers.unSubscribe(object)
        case .watchSingle:
            watchSinglePriceObservers.unSubscribe(object)
        default:
            break
        }
    }
    
    func stopStreams() {
        _ = channel?.close()
        try? eventLoopGroup?.syncShutdownGracefully()
        print("🛑🛑 \(ServiceClient.self) stopped 🛑🛑")
    }
}

// MARK: - ObservableDelegate
extension TradeService: ObservableDelegate {
    func subscriptonsDidChange(
        at streamType: INVStreamType,
        hasSubscribers: Bool) {
        switch streamType {
        case .tradeOperation:
            hasSubscribers ? operationsStreamConnect() : operationsStreamClose()
        case .watchSingle:
            hasSubscribers ? nil : watchSingleStreamClose()
        default:
            break
        }
    }
    
    func shouldRefresh(streamType: INVStreamType) {
        switch streamType {
        case .tradeOperation:
            operationsStreamConnect()
        default:
            break
        }
    }
}
