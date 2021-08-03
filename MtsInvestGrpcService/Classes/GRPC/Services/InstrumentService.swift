//
//  InstrumentsService.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 22.07.2021.
//

import GRPC
import NIO

protocol AnyInstrumentService: AnyObject {
    func getInstrumentsList(
        callOptions: CallOptions,
        completion: @escaping (Result<[INVInstrumentBrief], INVError>) -> Void)
    func subscribeInstrumentBrief(
        _ object: AnyObject,
        for tikers: [String],
        callOptions: CallOptions,
        completion: @escaping (Result<INVInstrumentBrief?, INVError>) -> Void)
    func getInstrument(
        instrumentID: String,
        callOptions: CallOptions,
        completion: @escaping (Result<INVInstrument, INVError>) -> Void)
    func getExchangeStatus(
        instrumentID: String,
        callOptions: CallOptions,
        completion: @escaping (Result<INVExchangeStatus, INVError>) -> Void)
}

final class InstrumentService: AnyService {
    typealias InstumentsServiceClient = InstrumentsServiceClient
    typealias InstumentServiceClient = Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClient
    
    // MARK: Private properties
    private let eventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    private var instrumentsService: InstumentsServiceClient?
    private var instrumentService: InstumentServiceClient?
    private var channel: ClientConnection?
    private var callOptions: CallOptions?
    
    private let instrumentsObservers: Observable<INVInstrumentBrief>
    
    private var (host, port): (String, Int)
    
    // MARK: Lifecycle
    init(
        host: String,
        port: Int) {
        (self.host, self.port) = (host, port)
        instrumentsObservers = .init(streamType: .instumentBrief)
        configureService()
    }
    
    deinit {
        stop()
    }
    
    // MARK: Private methods
    private func configureService() {
        channel = ClientConnection
            .usingPlatformAppropriateTLS(for: eventLoopGroup)
            .connect(
                host: host,
                port: port)
        guard let channel = channel else { return }
        instrumentsService = InstumentsServiceClient(channel: channel)
        instrumentService = InstumentServiceClient(channel: channel)
    }
    
    private func getInstrumentsList(
//        filter: InstrumentsFilter? = nil,
        completion: @escaping (Result<[INVInstrumentBrief], INVError>) -> Void) {
        DispatchQueue.global().async {
            let request = GetInstrumentsBriefRequest()
            /// Filters dont work yet
//                .with {
//                    $0.filter = filter
//                }
            let instrumentsFeature = self.instrumentsService?.listInstrumentsBriefFront(
                request,
                callOptions: self.callOptions)
            do {
                let response = try instrumentsFeature?.response.wait()
                let invInstruments = response?.instruments.map { INVInstrumentBrief(from: $0) } ?? []
                completion(.success(invInstruments))
            } catch {
                completion(.failure(INVError(from: error.localizedDescription)))
            }
            
            instrumentsFeature?.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                completion(.failure(error))
            }
        }
    }
    
    private func getInstrumentBriedStream(tikers: [String]) {
        guard let service = instrumentsService else { return }
        DispatchQueue.global().async {
            let request = GetInstrumentsBriefRequest.with {
                $0.filter = .with {
                    $0.tickers = tikers
                }
            }
            
            let stream = service.getInstrumentsBriefStream(
                request,
                callOptions: self.callOptions) { [weak self] instumentBrief in
                guard let self = self else { return }
                self.instrumentsObservers.onNext(INVInstrumentBrief(from: instumentBrief))
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
                    self.instrumentsObservers.onError(error)
                }   
            }
        }
        
    }
    
    private func getInstrumentInfo(
        instrumentID: String,
        completion: @escaping (Result<INVInstrument, INVError>) -> Void) {
        DispatchQueue.global().async {
            let request = Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest
                .with { $0.instrumentID = instrumentID }
            
            let instrumentCall = self.instrumentService?.getInstrument(
                request,
                callOptions: self.callOptions)
            
            do {
                let response = try instrumentCall?.response.wait()
                if let invInstrument = response.map({ INVInstrument(from: $0) }) {
                    completion(.success(invInstrument))
                } else {
                    completion(.failure(.error("MappingError at \(#function)")))
                }
            } catch {
                completion(.failure(.error(error.localizedDescription)))
            }
            
            instrumentCall?.status.whenComplete { [weak self] result in
                guard
                    let self = self,
                    let error = self.parseStatus(from: result)
                else { return }
                completion(.failure(error))
                
            }
        }
    }
    
    private func getExchangeStatus(
        instrumentID: String,
        completion: @escaping (Result<INVExchangeStatus, INVError>) -> Void) {
        let request = Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest
            .with { $0.instrumentID = instrumentID }
        let instrumentCall = self.instrumentService?.getExchangeStatus(
            request,
            callOptions: self.callOptions)
        do {
            let response = try instrumentCall?.response.wait()
            if let invExchangeStatus = response.map({ INVExchangeStatus(from: $0) }) {
                completion(.success(invExchangeStatus))
            } else {
                completion(.failure(.error("MappingError at \(#function)")))
            }
        } catch {
            completion(.failure(.error(error.localizedDescription)))
        }
    }
}

// MARK: - AnyInstrumentService
extension InstrumentService: AnyInstrumentService {
    // MARK: Public methods
    func getInstrumentsList(
        callOptions: CallOptions,
        completion: @escaping (Result<[INVInstrumentBrief], INVError>) -> Void) {
        self.callOptions = callOptions
        getInstrumentsList(completion: completion)
    }
    
    func subscribeInstrumentBrief(
        _ object: AnyObject,
        for tikers: [String],
        callOptions: CallOptions,
        completion: @escaping (Result<INVInstrumentBrief?, INVError>) -> Void) {
        self.callOptions = callOptions
        instrumentsObservers.subscribe(
            object,
            event: completion)
        getInstrumentBriedStream(tikers: tikers)
    }
    
    func getInstrument(
        instrumentID: String,
        callOptions: CallOptions,
        completion: @escaping (Result<INVInstrument, INVError>) -> Void) {
        self.callOptions = callOptions
        getInstrumentInfo(
            instrumentID: instrumentID,
            completion: completion)
    }
    
    func getExchangeStatus(
        instrumentID: String,
        callOptions: CallOptions,
        completion: @escaping (Result<INVExchangeStatus, INVError>) -> Void) {
        self.callOptions = callOptions
        getExchangeStatus(
            instrumentID: instrumentID,
            completion: completion)
    }
    
    func stop() {
        _ = channel?.close()
        try? eventLoopGroup.syncShutdownGracefully()
        print("🛑🛑 \(InstumentsServiceClient.self) stopped 🛑🛑")
    }
}
