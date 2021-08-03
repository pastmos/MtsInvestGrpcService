//
//  GRPCClass.swift
//  Pods
//
//  Created by Sergey Panov on 01.07.2021.
//

import Foundation
import GRPC

open class MtsGRPCClass {
    // MARK: - Private properties
    private let host: String
    private let port: Int
    private var callOptions = CallOptions()
    private var brokerService: AnyBrokerPorfolioService?
    private var instrumentsService: AnyInstrumentService?
    private var tradeService: AnyTradeService?
    
    // MARK: - Lifecycle
    public init(
        host: String,
        port: Int) {
        self.host = host
        self.port = port
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
    
    // MARK: Streams
    public func unsubscribe(
        _ object: AnyObject,
        from streamType: [INVStreamType]) {
        streamType.forEach {
            switch $0 {
            case .brokerPorfolio:
                brokerService?.unsubscribe(object: object)
            case .tradeOperation,
                 .watchSingle:
                tradeService?.unsubscribe(
                    object: object,
                    from: $0)
            case .instumentBrief:
                break
            }
        }
    }
}

// MARK: Broker porfolio stream
extension MtsGRPCClass {
    public func subscribeBrokerPorfolio(
        _ object: AnyObject,
        event: @escaping (Result<INVBrokerPortfolioResponse?, INVError>) -> Void) {
        if brokerService == nil {
            brokerService = BrokerPorfolioService(
                host: host,
                port: port)
        }
        brokerService?.subscribe(
            object: object,
            for: .allTime,
            callOptions: callOptions,
            completion: event)
    }
}

// MARK: Instruments
extension MtsGRPCClass {
    private func makeInstrumentsService() {
        instrumentsService = InstrumentService(
            host: host,
            port: port)
    }
    
    public func subscribeInstruments(
        _ object: AnyObject,
        for tikers: [String],
        completion: @escaping (Result<INVInstrumentBrief?, INVError>) -> Void) {
        if instrumentsService == nil { makeInstrumentsService() }
        instrumentsService?.subscribeInstrumentBrief(
            object,
            for: tikers,
            callOptions: callOptions,
            completion: completion)
    }
    
    public func getInstrumentsList(completion: @escaping (Result<[INVInstrumentBrief], INVError>) -> Void) {
        if instrumentsService == nil { makeInstrumentsService() }
        instrumentsService?.getInstrumentsList(
            callOptions: callOptions,
            completion: completion)
    }
    
    public func getInstrumet(
        instrumentID: String,
        completion: @escaping (Result<INVInstrument, INVError>) -> Void) {
        if instrumentsService == nil { makeInstrumentsService() }
        instrumentsService?.getInstrument(
            instrumentID: instrumentID,
            callOptions: callOptions,
            completion: completion)
    }
    
    public func getExchangeStatus(
        instrumentID: String,
        completion: @escaping (Result<INVExchangeStatus, INVError>) -> Void) {
        if instrumentsService == nil { makeInstrumentsService() }
        instrumentsService?.getExchangeStatus(
            instrumentID: instrumentID,
            callOptions: callOptions,
            completion: completion)
    }
}

// MARK: Trade
extension MtsGRPCClass {
    private func makeTradeService() {
        tradeService = TradeService(
            host: host,
            port: port)
    }
    
    public func subscribeTradeOperation(
        _ object: AnyObject,
        event: @escaping (Result<INVTradingOrder?, INVError>) -> Void) {
        if tradeService == nil { makeTradeService() }
        tradeService?.subscribeOperation(
            object: object,
            callOptions: callOptions,
            completion: event)
    }
    
    public func subscribeWatchSinglePrice(
        _ object: AnyObject,
        request: INVTradingWatchRequest,
        event: @escaping (Result<INVTradingWatchPrice?, INVError>) -> Void) {
        if tradeService == nil { makeTradeService() }
        tradeService?.subscribeWatchSingle(
            object: object,
            request: request,
            callOptions: callOptions,
            completion: event)
    }
    
    /// - Parameters:
    ///     - ids: Array of order id to hide
    ///     - completion: Backend response empty, just check it for error. If error doesnt exists - ok.
    public func hideOrder(
        ids: [Int],
        completion: @escaping (INVError?) -> Void) {
        if tradeService == nil { makeTradeService() }
        tradeService?.hideOrder(
            ids: ids,
            completion: completion)
    }
}
