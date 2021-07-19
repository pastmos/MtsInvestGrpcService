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
    var lifecycleStage: Ru_Mts_Trading_Broker_Commons_PositionLifecycleStage // YS TODO: Make model
}
