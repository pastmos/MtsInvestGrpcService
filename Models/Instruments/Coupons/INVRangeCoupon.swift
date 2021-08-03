//
//  INVRangeCoupon.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVRangeCoupon {
    let couponMin: Double
    let couponMax: Double
    ///предыдущее значение, если оно было изменено
    let previousCouponMin: Double?
    let previousCouponMax: Double?
    let couponStep: Double
}

extension INVRangeCoupon: Equatable { }

extension INVRangeCoupon {
    init(from grpcRangeCoupon: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_BookBuilding.TypeCouponRange) {
        self.couponMin = Double(grpcRangeCoupon.couponMin.value) ?? 0.0
        self.couponMax = Double(grpcRangeCoupon.couponMax.value) ?? 0.0
        self.previousCouponMin = grpcRangeCoupon.hasPreviousCouponMin ?
            Double(grpcRangeCoupon.previousCouponMin.value.value) : nil
        self.previousCouponMax = grpcRangeCoupon.hasPreviousCouponMax ?
            Double(grpcRangeCoupon.previousCouponMax.value.value) : nil
        self.couponStep = Double(grpcRangeCoupon.couponStep.value) ?? 0.0
    }
}
