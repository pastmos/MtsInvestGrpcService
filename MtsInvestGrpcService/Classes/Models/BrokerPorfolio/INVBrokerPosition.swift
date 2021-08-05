//
//  BrokerPosition.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public struct INVBrokerPosition {
    public let id: String
    /// идентификатор инструмента
    public let name: String
    /// описание
    public let subTitle: String
    /// сумма
    public let amount: Double
    /// средняя цена
    public let averagePrice: Double
    /// доходность
    public let yield: Double
    /// доход
    public let income: Double
    /// доходность в годовых
    public let yieldPerAnnum: Double
    /// дата приобретения
    public let purchaseDate: Date
    /// отмечен ли как избранный
    public let isFavorite: Bool
    /// показатель сортировки
    public let sort: Int
    /// группа бумаг
    public let group: INVBrokerPositionGroup
    /// валюта
    public let currency: INVCurrency
    /// новый тип бумаги
    public let instrumentCommonType: INVInstrumentCommonType
    /// дата погашения
    public let maturityDate: Date
    /// погашена ли
    public let isMaturity: Bool
    /// сумма в рублях
    public let amountRub: Double
    /// доходность в рублях
    public let yieldRub: Double
    /// доход в рублях
    public let incomeRub: Double
    /// доходность в годовых в рублях
    public let yieldPerAnnumRub: Double
    /// количество активов
    public let quantity: Double
    /// стредства в пути
    public let moneyFlowAmount: Double
    /// этап жизненного цикла позиции
    public let lifecycleStage: INVBrokerPositionLifecycleStage
}

extension INVBrokerPosition {
    init(from grpcModel: Ru_Mts_Trading_Broker_Commons_Position) {
        self.id = grpcModel.id
        self.name = grpcModel.name
        self.subTitle = grpcModel.subTitle
        self.amount = Double(grpcModel.amount.value) ?? 0.0
        self.averagePrice = Double(grpcModel.averagePrice.value) ?? 0.0
        self.yield = Double(grpcModel.yield.value) ?? 0.0
        self.income = Double(grpcModel.income.value) ?? 0.0
        self.yieldPerAnnum = Double(grpcModel.yieldPerAnnum.value) ?? 0.0
        self.purchaseDate = Date(timeIntervalSinceReferenceDate: grpcModel.purchaseDate.timeIntervalSince1970)
        self.isFavorite = grpcModel.isFavorite
        self.sort = Int(grpcModel.sort.value) ?? -1
        self.group = .init(rawValue: grpcModel.group.rawValue)
        self.currency = .init(from: grpcModel.currency)
        self.instrumentCommonType = INVInstrumentCommonType(from: grpcModel.instrumentCommonType)
        self.maturityDate = Date(timeIntervalSinceReferenceDate: grpcModel.maturityDate.timeIntervalSince1970)
        self.isMaturity = grpcModel.isMaturity
        self.amountRub = Double(grpcModel.amountRub.value) ?? 0.0
        self.yieldRub = Double(grpcModel.yieldRub.value) ?? 0.0
        self.incomeRub = Double(grpcModel.incomeRub.value) ?? 0.0
        self.yieldPerAnnumRub = Double(grpcModel.yieldPerAnnumRub.value) ?? 0.0
        self.quantity = Double(grpcModel.quantity.value) ?? 0.0
        self.moneyFlowAmount = Double(grpcModel.moneyFlowAmount.value) ?? 0.0
        self.lifecycleStage = .init(rawValue: grpcModel.lifecycleStage.rawValue)
    }
}


