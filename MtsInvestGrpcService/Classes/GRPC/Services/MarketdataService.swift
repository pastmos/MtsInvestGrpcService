//
//  MarketdataService.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 04.08.2021.
//

import GRPC
import NIO

protocol AnyMarketDataService: AnyObject {
    func subscribe(
        _ object: AnyObject,
        instrumentID: String,
        period: INVTimeBox,
        callOptions: CallOptions,
        event: @escaping (Result<INVMarketDataResponse?, INVError>) -> Void)
    func unsubscribe(object: AnyObject)
    func setPeriod(_ period: INVTimeBox)
    func fetchMDForPeriod(
        request: INVMDForPeriodRequest,
        callOptions: CallOptions)
    func getInstrumentIndicators(
        instrumentID: String,
        callOptions: CallOptions,
        completion: @escaping (Result<INVIndicatorsResponse?, INVError>) -> Void)
    func stopStream()
}

final class MarketdataService: AnyService {
    typealias ServiceClient = Ru_Mts_Trading_Marketdata_MarketDataServiceClient
    
    // MARK: Private properties
    private var eventLoopGroup: EventLoopGroup?
    private var service: ServiceClient?
    private var channel: ClientConnection?
    private var callOptions: CallOptions?
    private var (host, port): (String, Int)
    private var instrumentID: String = ""
    private var period: INVTimeBox = .month
//    {
//        didSet {
//            guard oldValue.grpcModel() != period.grpcModel() else { return }
//            getMarketData()
//        }
//    }
    private let marketdataObservers: Observable<INVMarketDataResponse>
    
    // MARK: Lifecycle
    init(
        host: String,
        port: Int) {
        (self.host, self.port) = (host, port)
        marketdataObservers = .init(streamType: .marketData)
        marketdataObservers.delegate = self
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
    
    private func getIndicators(
        instrumentID: String,
        completion: @escaping (Result<INVIndicatorsResponse?, INVError>) -> Void) {
        guard let service = service else { return }
        DispatchQueue.global().async {
            let request = Ru_Mts_Trading_Marketdata_GetIndicatorsRequest.with {
                $0.instrumentID = instrumentID
            }
            let call = service.getIndicators(
                request,
                callOptions: self.callOptions)
            
            do {
                let response = try call.response.wait()
                completion(.success(INVIndicatorsResponse(from: response)))
            } catch {
                completion(.failure(.error(error.localizedDescription)))
            }
            
            call.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                switch error {
                case .unavailable:
                    self.configureService()
                    self.getIndicators(
                        instrumentID: instrumentID,
                        completion: completion)
                default:
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func getMDForPeriod(
        request: INVMDForPeriodRequest) {
        guard let service = service else { return }
        DispatchQueue.global().async {
            let stream = service.getMDForPeriod(
                request.grpcModel(),
                callOptions: self.callOptions) { [weak self] response in
                guard
                    let self = self,
                    response.startTime != 0,
                    !response.value.isEmpty
                else { return }
                self.marketdataObservers.onNext(INVMarketDataResponse(from: response))
            }
            
            stream.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                switch error {
                case .unavailable:
                    self.configureService()
                    self.getMDForPeriod(request: request)
                default:
                    self.marketdataObservers.onError(error)
                }
            }
        }
    }
    
    private func getMarketData() {
        guard let service = service else { return }
        DispatchQueue.global().async {
            let request = Ru_Mts_Trading_Marketdata_MarketDataRequest
                .with {
                    $0.instrumentID = self.instrumentID
                    $0.timeBox = self.period.grpcModel()
                }
            let stream = service.getMarketData(
                request,
                callOptions: self.callOptions) { [weak self] response in
                guard
                    let self = self,
                    response.startTime != 0,
                    !response.value.isEmpty
                else { return }
                self.marketdataObservers.onNext(INVMarketDataResponse(from: response))
            }
            
            stream.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                switch error {
                case .unavailable:
                    self.configureService()
                    self.getMarketData()
                default:
                    self.marketdataObservers.onError(error)
                }
            }
        }
    }
}

extension MarketdataService: AnyMarketDataService {
    func subscribe(
        _ object: AnyObject,
        instrumentID: String,
        period: INVTimeBox,
        callOptions: CallOptions,
        event: @escaping (Result<INVMarketDataResponse?, INVError>) -> Void) {
        self.callOptions = callOptions
        self.instrumentID = instrumentID
        self.period = period
        marketdataObservers.subscribe(
            object,
            event: event)
        getMarketData()
    }
    
    func unsubscribe(object: AnyObject) {
        marketdataObservers.unSubscribe(object)
    }
    
    func setPeriod(_ period: INVTimeBox) {
        self.period = period
        getMarketData()
    }
    
    func fetchMDForPeriod(
        request: INVMDForPeriodRequest,
        callOptions: CallOptions) {
        self.callOptions = callOptions
        getMDForPeriod(request: request)
    }
    
    func getInstrumentIndicators(
        instrumentID: String,
        callOptions: CallOptions,
        completion: @escaping (Result<INVIndicatorsResponse?, INVError>) -> Void) {
        self.callOptions = callOptions
        getIndicators(
            instrumentID: instrumentID,
            completion: completion)
    }
    
    func stopStream() {
        _ = channel?.close()
        try? eventLoopGroup?.syncShutdownGracefully()
        print("🛑🛑 \(ServiceClient.self) stopped 🛑🛑")
    }
}

// MARK: - ObservableDelegate
extension MarketdataService: ObservableDelegate {
    func subscriptonsDidChange(
        at streamType: INVStreamType,
        hasSubscribers: Bool) {
        hasSubscribers ? getMarketData() : stopStream()
    }
    
    func shouldRefresh(streamType: INVStreamType) {
//        getBrokerPorfolio()
    }
}
