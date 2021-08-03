//
//  INVInstrumentBookbuilding.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVInstrumentBookbuilding {
    let type: INVCouponType?
    let couponRangeType: INVRangeCoupon
    let couponFixType: INVFixCoupon
    let minLotCount: Int
    let maxLotCount: Int
    ///Старт приёма заявок (дата и время в UTC)
    let bookBuildingStart: Date
    ///Окончание приёма заявок (дата и время в UTC)
    let bookBuildingFinish: Date
    ///размер комиссии в процентах
    let feePercent: Double
    ///ожидаемая доходность в % годовых
    let yieldPerAnnum: INVYieldPerAnnum?
    ///точное значение (например, для фиксированного купона)
    let yieldPerAnnumValue: Double
    ///диапазон (например, для диапазона купона)
    let yieldPerAnnumRange: INVYieldPerAnnumRange
    let price: Double
    let contraBroker: String
}

extension INVInstrumentBookbuilding {
    init(from grpcModel: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_BookBuilding) {
        self.type = INVCouponType(from: grpcModel.type)
        self.couponRangeType = INVRangeCoupon(from: grpcModel.couponRangeType)
        self.couponFixType = INVFixCoupon(from: grpcModel.couponFixType)
        self.minLotCount = Int(grpcModel.minLotCount)
        self.maxLotCount = Int(grpcModel.maxLotCount)
        self.bookBuildingStart = grpcModel.bookBuildingStart.toDate() ?? Date()
        self.bookBuildingFinish = grpcModel.bookBuildingFinish.toDate() ?? Date()
        self.feePercent = Double(grpcModel.feePercent.value) ?? 0.0
        self.yieldPerAnnum = INVYieldPerAnnum(from: grpcModel.yieldPerAnnum)
        self.yieldPerAnnumValue = Double(grpcModel.yieldPerAnnumValue.value) ?? 0.0
        self.yieldPerAnnumRange = INVYieldPerAnnumRange(from: grpcModel.yieldPerAnnumRange)
        self.price = Double(grpcModel.price.value) ?? 0.0
        self.contraBroker = grpcModel.contraBroker
    }
}
