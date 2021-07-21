//
//  BrokerPorfolioService.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 15.07.2021.
//

import GRPC
import NIO

final class BrokerPorfolioService {
    typealias ServiceClient = Ru_Mts_Trading_Broker_BrokerPortfolioServiceClient
    
    // MARK: Private properties
    private let eventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    private var service: ServiceClient?
    private var channel: ClientConnection?
    private var callOptions: CallOptions?
    
    // MARK: Lifecycle
    init(
        host: String,
        port: Int) {
        configureService(
            host: host,
            port: port)
    }
    
    deinit {
        stopStream()
    }
    
    // MARK: Private methods
    private func configureService(
        host: String,
        port: Int) {
        channel = ClientConnection
            .usingPlatformAppropriateTLS(for: eventLoopGroup)
            .connect(
                host: host,
                port: port)
        guard let channel = channel else { return }
        service = ServiceClient(channel: channel)
    }
    
    private func getBrokerPorfolio(
        for period: Ru_Mts_Trading_Broker_Commons_Period = .allTime,
        completion: @escaping (Result<BrokerPortfolioResponse, INVError>) -> Void) {
        guard let service = service else { return }
        DispatchQueue.global().async {
            let stream = service
                .getStreamV2(
                    .with { $0.period = period },
                    callOptions: self.callOptions) { response in
                    completion(.success(BrokerPortfolioResponse(from: response)))
                }
            
            stream.status.whenSuccess { status in
                switch status.code {
                case .ok,
                     .cancelled,
                     .unknown,
                     .deadlineExceeded,
                     .unavailable:
                    break
                default:
                    completion(.failure(INVError(from: status.code)))
                }
            }
            
            stream.status.whenFailure {
                print("‼️‼️ \($0.localizedDescription) ‼️‼️")
                completion(.failure(INVError(from: $0.localizedDescription)))
            }
        }
    }
    
    // MARK: Public methods
    public func restartStream(
        for period: Ru_Mts_Trading_Broker_Commons_Period = .allTime,
        callOptions: CallOptions,
        completion: @escaping (Result<BrokerPortfolioResponse, INVError>) -> Void) {
        self.callOptions = callOptions
        getBrokerPorfolio(
            for: period,
            completion: completion)
    }
    
    public func stopStream() {
        _ = channel?.close()
        try? eventLoopGroup.syncShutdownGracefully()
        print("🛑🛑 \(ServiceClient.self) stopped 🛑🛑")
    }
    
    
}
