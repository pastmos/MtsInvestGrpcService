//
//  INVFixCoupon.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVFixCoupon {
    public let coupon: Double
    public let previousCoupon: Double?
}

extension INVFixCoupon: Equatable { }

extension INVFixCoupon {
    init(from grpcFixCoupon: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_BookBuilding.TypeCouponFix) {
        self.coupon = Double(grpcFixCoupon.coupon.value) ?? 0.0
        self.previousCoupon = grpcFixCoupon.hasPreviousCoupon ?
            Double(grpcFixCoupon.previousCoupon.value.value) : nil
    }
}
