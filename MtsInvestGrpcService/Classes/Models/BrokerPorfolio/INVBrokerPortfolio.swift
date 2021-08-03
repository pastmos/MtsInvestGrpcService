//
//  BrokerPortfolio.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public struct INVBrokerPortfolio {
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
