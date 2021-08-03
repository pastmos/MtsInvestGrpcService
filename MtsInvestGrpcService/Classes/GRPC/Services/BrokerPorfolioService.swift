//
//  BrokerPorfolioService.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 15.07.2021.
//

import GRPC
import NIO

protocol AnyBrokerPorfolioService {
    func subscribe(
        object: AnyObject,
        for period: Ru_Mts_Trading_Broker_Commons_Period,
        callOptions: CallOptions,
        completion: @escaping (Result<INVBrokerPortfolioResponse?, INVError>) -> Void)
    func unsubscribe(object: AnyObject)
    func stopStream()
}

final class BrokerPorfolioService: AnyService {
    typealias ServiceClient = Ru_Mts_Trading_Broker_BrokerPortfolioServiceClient
    
    // MARK: Private properties
    private var eventLoopGroup: EventLoopGroup?
    private var service: ServiceClient?
    private var channel: ClientConnection?
    private var callOptions: CallOptions?
    private var brokerPortfolioObservers: Observable<INVBrokerPortfolioResponse>
    
    private var (host, port): (String, Int)
    
    // MARK: Lifecycle
    init(
        host: String,
        port: Int) {
        (self.host, self.port) = (host, port)
        brokerPortfolioObservers = .init(streamType: .brokerPorfolio)
        brokerPortfolioObservers.delegate = self
        configureService()
    }
    
    deinit {
        stopStream()
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
    
    private func getBrokerPorfolio(
        for period: Ru_Mts_Trading_Broker_Commons_Period = .allTime) {
        guard let service = service else { return }
        DispatchQueue.global().async {
            let stream = service
                .getStreamV2(
                    .with { $0.period = period },
                    callOptions: self.callOptions) { [weak self] response in
                    self?.brokerPortfolioObservers.onNext(INVBrokerPortfolioResponse(from: response))
                }
            
            stream.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                switch error {
                case .unavailable:
                    self.configureService()
                default:
                    self.brokerPortfolioObservers.onError(error)
                }
            }
        }
    }
}

// MARK: - AnyBrokerPorfolioService
extension BrokerPorfolioService: AnyBrokerPorfolioService {
    func subscribe(
        object: AnyObject,
        for period: Ru_Mts_Trading_Broker_Commons_Period = .allTime,
        callOptions: CallOptions,
        completion: @escaping (Result<INVBrokerPortfolioResponse?, INVError>) -> Void) {
        self.callOptions = callOptions
        brokerPortfolioObservers.subscribe(
            object,
            event: completion)
        getBrokerPorfolio(for: period)
    }
    
    func unsubscribe(object: AnyObject) {
        brokerPortfolioObservers.unSubscribe(object)
    }
    
    func stopStream() {
        _ = channel?.close()
        try? eventLoopGroup?.syncShutdownGracefully()
        print("🛑🛑 \(ServiceClient.self) stopped 🛑🛑")
    }
}

// MARK: - ObservableDelegate
extension BrokerPorfolioService: ObservableDelegate {
    func subscriptonsDidChange(
        at streamType: INVStreamType,
        hasSubscribers: Bool) {
        hasSubscribers ? getBrokerPorfolio() : stopStream()
    }
    
    func shouldRefresh(streamType: INVStreamType) {
        getBrokerPorfolio()
    }
}
