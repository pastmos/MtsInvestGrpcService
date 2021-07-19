//
//  BrokerPortfolio.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public struct BrokerPortfolio {
    /// идентификатор портфеля
    let name: String
    /// цена ликвидации
    let liquidationValue: Double
    /// сумма по инмтрументам
    let assetsValue: Double
    /// свободные средства
    let freeValue: Double
    /// зарезирвированные (заблокированные) средства (freeValue - availableWithdrawAmount)
    let reservedValue: Double
    /// доходность
    let yield: Double
    /// доход
    let income: Double
    /// доходность в годовых
    let yieldPerAnnum: Double
    /// номер договора
    let contractID: String
    /// сумма доступная к выводу
    let availableWithdrawAmount: Double
    /// Максимальная дата, когда будет разблокировано reservedValue. Опционально, заполняется, только если reservedValue > 0
    let reservedUntil: Date?
    
    init(from commonPortfolio: Ru_Mts_Trading_Broker_Commons_Portfolio) {
        self.name = commonPortfolio.name
        self.liquidationValue = Double(commonPortfolio.liquidationValue.value) ?? 0.0
        self.assetsValue = Double(commonPortfolio.assetsValue.value) ?? 0.0
        self.freeValue = Double(commonPortfolio.freeValue.value) ?? 0.0
        self.reservedValue = Double(commonPortfolio.reservedValue.value) ?? 0.0
        self.yield = Double(commonPortfolio.yield.value) ?? 0.0
        self.income = Double(commonPortfolio.income.value) ?? 0.0
        self.yieldPerAnnum = Double(commonPortfolio.yieldPerAnnum.value) ?? 0.0
        self.contractID = commonPortfolio.contractID
        self.availableWithdrawAmount = Double(commonPortfolio.availableWithdrawAmount.value) ?? 0.0
        self.reservedUntil = commonPortfolio.hasReservedUntil ?
            commonPortfolio.reservedUntil.value.toDate() : nil
    }
}

public struct BrokerPortfolioResponse {
    let portfolio: BrokerPortfolio
//    let positions: [BrokerPositions]
//    let status: BrokerPortfolioStatus
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
