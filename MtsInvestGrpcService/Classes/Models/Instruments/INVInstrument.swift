//
//  INVInstrument.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVInstrument {
    public let instrumentID: String
    ///характеризует биржу, на которой торгуется инструмент
    public let classCode: String
    ///обобщенный тип инструмента(акция, облигация, ETF, валюта)
    public let type: INVInstrumentCommonType
    public let isin: String
    ///не уникальный ключ, видимый пользователю
    public let ticker: String
    ///название
    public let name: String
    ///подробное описание
    public let description: String
    ///размер лота
    public let lotSize: Int
    ///номинал в валюте
    public let faceValue: Double
    ///дата погашения
    public let maturityDate: Date?
    ///валюта
    public let currency: INVCurrency
    ///минимальный шаг изменения цены при выставлении заявки
    public let minStep: Double
    ///количество знаков после запятой в цене
    public let decimals: Int
    //ставка купона [облигации]
    public let coupon: Double
    ///дата выплаты следующего купона [облигации]
    public let nextCoupon: Date?
    ///НКД [облигации]
    public let accruedInterest: Double
    public let state: INVInstrumentState
    public let bookBuilding: INVInstrumentBookbuilding
    ///идентификатор расписания торгов инструмента
    public let scheduleID: String
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
