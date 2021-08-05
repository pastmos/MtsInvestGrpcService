//
//  BrokerPortfolio.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public struct INVBrokerPortfolio {
    /// идентификатор портфеля
    public let name: String
    /// цена ликвидации
    public let liquidationValue: Double
    /// сумма по инмтрументам
    public let assetsValue: Double
    /// свободные средства
    public let freeValue: Double
    /// зарезирвированные (заблокированные) средства (freeValue - availableWithdrawAmount)
    public let reservedValue: Double
    /// доходность
    public let yield: Double
    /// доход
    public let income: Double
    /// доходность в годовых
    public let yieldPerAnnum: Double
    /// номер договора
    public let contractID: String
    /// сумма доступная к выводу
    public let availableWithdrawAmount: Double
    /// Максимальная дата, когда будет разблокировано reservedValue. Опционально, заполняется, только если reservedValue > 0
    public let reservedUntil: Date?
    
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
