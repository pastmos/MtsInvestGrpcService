//
//  INVInstrument.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVInstrument {
    let instrumentID: String
    ///характеризует биржу, на которой торгуется инструмент
    let classCode: String
    ///обобщенный тип инструмента(акция, облигация, ETF, валюта)
    let type: INVInstrumentCommonType
    let isin: String
    ///не уникальный ключ, видимый пользователю
    let ticker: String
    ///название
    let name: String
    ///подробное описание
    let description: String
    ///размер лота
    let lotSize: Int
    ///номинал в валюте
    let faceValue: Double
    ///дата погашения
    let maturityDate: Date?
    ///валюта
    let currency: INVCurrency
    ///минимальный шаг изменения цены при выставлении заявки
    let minStep: Double
    ///количество знаков после запятой в цене
    let decimals: Int
    //ставка купона [облигации]
    let coupon: Double
    ///дата выплаты следующего купона [облигации]
    let nextCoupon: Date?
    ///НКД [облигации]
    let accruedInterest: Double
    let state: INVInstrumentState
    let bookBuilding: INVInstrumentBookbuilding
    ///идентификатор расписания торгов инструмента
    let scheduleID: String
}

extension INVInstrument {
    init(from grpcModel: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_Instrument) {
        self.instrumentID = grpcModel.instrumentID
        self.classCode = grpcModel.classCode
        self.type = INVInstrumentCommonType(from: grpcModel.type)
        self.isin = grpcModel.isin
        self.ticker = grpcModel.ticker
        self.name = grpcModel.name
        self.description = grpcModel.description_p
        self.lotSize = Int(grpcModel.lotSize)
        self.faceValue = Double(grpcModel.faceValue.value) ?? 0.0
        self.maturityDate = grpcModel.maturityDate.toDate()
        self.currency = INVCurrency(from: grpcModel.currency)
        self.minStep = Double(grpcModel.minStep.value) ?? 0.0
        self.decimals = Int(grpcModel.decimals)
        self.coupon = Double(grpcModel.coupon.value) ?? 0.0
        self.nextCoupon = grpcModel.nextCoupon.toDate()
        self.accruedInterest = Double(grpcModel.accruedInterest.value) ?? 0.0
        self.state = INVInstrumentState(from: grpcModel.state)
        self.bookBuilding = INVInstrumentBookbuilding(from: grpcModel.bookBuilding)
        self.scheduleID = grpcModel.scheduleID
    }
}
