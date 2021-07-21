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
    // MARK: - Private properties
    private let host: String
    private let port: Int
    private var callOptions = CallOptions()
    private var brokerService: BrokerPorfolioService?
    
    // MARK: BrokerPorfolio
    private var brokerPortfolioObservers: Observable<BrokerPortfolioResponse>
    
    // MARK: - Lifecycle
    public init(
        host: String,
        port: Int) {
        self.host = host
        self.port = port
        
        brokerPortfolioObservers = .init(streamType: .brokerPorfolio)
    }
    
    // MARK: - Private methods
    // MARK: BrokerPorfolio
    private func startBrokerPortfolioStream() {
        if brokerService == nil {
            brokerService = BrokerPorfolioService(
                host: host,
                port: port)
        }
        
        brokerService?.restartStream(
            for: .allTime,
            callOptions: callOptions) { [weak self] result in
            switch result {
            case .success(let brokerPortfolio):
                self?.brokerPortfolioObservers.onNext(brokerPortfolio)
            case .failure(let error):
                self?.brokerPortfolioObservers.onError(error)
            }
        }
    }
    
    private func closeBrokerPortfolioStream() {
        brokerService?.stopStream()
        brokerService = nil
    }
    
    // MARK: - Public methods
    // MARK: Token
    @discardableResult
    public func setToken(_ token: String) -> Self {
        callOptions.customMetadata.replaceOrAdd(
            name: "authorization",
            value: token)
        return self
    }
    
    // MARK: Subscribe
    public func subscribeBrokerPorfolio(
        _ object: AnyObject,
        event: @escaping (Result<BrokerPortfolioResponse?, INVError>) -> Void) {
        brokerPortfolioObservers.delegate = self
        brokerPortfolioObservers.subscribe(
            object,
            event: event)
    }
    
    public func unsubscribe(
        _ object: AnyObject,
        from streamType: StreamType) {
        switch streamType {
        case .brokerPorfolio:
            brokerPortfolioObservers.unSubscribe(object)
        }
    }
}


extension MtsGRPCClass: ObservableDelegate {
    func subscriptonsDidChange(
        at streamType: StreamType,
        hasSubscribers: Bool) {
        switch streamType {
        case .brokerPorfolio:
            hasSubscribers ? startBrokerPortfolioStream() : closeBrokerPortfolioStream()
        
        }
    }
    
    func shouldRefresh(streamType: StreamType) {
        switch streamType {
        case .brokerPorfolio:
            startBrokerPortfolioStream()
        }
    }
}
