//
//  GRPCClass.swift
//  Pods
//
//  Created by Sergey Panov on 01.07.2021.
//

import Foundation
import SnapKit
import GRPC

open class MtsGRPCClass {
    // MARK: Private properties
    private let host: String
    private let port: Int
    private var callOptions = CallOptions()
    private var brokerService: BrokerPorfolioService?
    
    // MARK: Lifecycle
    public init(
        host: String,
        port: Int) {
        self.host = host
        self.port = port
    }
    
    // MARK: Private methods
    
    // MARK: Public methods
    @discardableResult
    public func setToken(_ token: String) -> Self {
        callOptions.customMetadata.replaceOrAdd(
            name: "authorization",
            value: token)
        return self
    }
    
    public func getBrokerPortfolio(completion: @escaping (Result<BrokerPortfolioResponse, INVError>) -> Void) {
        brokerService = BrokerPorfolioService(
            host: host,
            port: port,
            callOptions: callOptions)
        brokerService?.getBrokerPorfolio(
            for: .allTime,
            callOptions: callOptions,
            completion: completion)
    }
    
    public func closeSteam() {
        brokerService?.stopStream()
    }
}
