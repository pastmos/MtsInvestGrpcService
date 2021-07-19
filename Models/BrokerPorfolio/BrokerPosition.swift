//
//  BrokerPosition.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public struct BrokerPosition {
    let id: String
    /// идентификатор инструмента
    let name: String
    /// описание
    let subTitle: String
    /// сумма
    let amount: Double
    /// средняя цена
    let averagePrice: Double
    /// доходность
    let yield: Double
    /// доход
    let income: Double
    /// доходность в годовых
    let yieldPerAnnum: Double
    /// дата приобретения
    let purchaseDate: Date
    /// отмечен ли как избранный
    let isFavorite: Bool
    /// показатель сортировки
    let sort: Int
    /// группа бумаг
    let group: BrokerPositionGroup
    /// валюта
    let currency: Currency
    /// новый тип бумаги
    let instrumentCommonType: InstrumentCommonType
    /// дата погашения
    let maturityDate: Date
    /// погашена ли
    let isMaturity: Bool
    /// сумма в рублях
    let amountRub: Double
    /// доходность в рублях
    let yieldRub: Double
    /// доход в рублях
    let incomeRub: Double
    /// доходность в годовых в рублях
    let yieldPerAnnumRub: Double
    /// количество активов
    let quantity: Double
    /// стредства в пути
    let moneyFlowAmount: Double
    /// этап жизненного цикла позиции
    let lifecycleStage: BrokerPositionLifecycleStage
}

extension BrokerPosition {
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
        self.currency = .init(grpcCurrency: grpcModel.currency)
        self.instrumentCommonType = .init(with: grpcModel.instrumentCommonType)
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


