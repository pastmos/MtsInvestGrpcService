//
//  BrokerPorfolioResponse.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//


public struct BrokerPortfolioResponse {
    let portfolio: BrokerPortfolio
    let positions: [BrokerPositions]
    let status: BrokerPortfolioStatus
}

/*
 var portfolio: Ru_Mts_Trading_Broker_Commons_Portfolio {
     get {return _storage._portfolio ?? Ru_Mts_Trading_Broker_Commons_Portfolio()}
     set {_uniqueStorage()._portfolio = newValue}
 }
 /// Returns true if `portfolio` has been explicitly set.
 var hasPortfolio: Bool {return _storage._portfolio != nil}
 /// Clears the value of `portfolio`. Subsequent reads from it will return its default value.
 mutating func clearPortfolio() {_uniqueStorage()._portfolio = nil}
 
 var positions: [Ru_Mts_Trading_Broker_Commons_Position] {
     get {return _storage._positions}
     set {_uniqueStorage()._positions = newValue}
 }
 
 var status: Ru_Mts_Trading_Broker_Commons_PortfolioStatus {
     get {return _storage._status}
     set {_uniqueStorage()._status = newValue}
 }
 
 var unknownFields = SwiftProtobuf.UnknownStorage()
 
 init() {}
 
 fileprivate var _storage = _StorageClass.defaultInstance
}
 */
