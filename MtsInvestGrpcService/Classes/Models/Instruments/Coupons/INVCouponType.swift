//
//  INVCouponType.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public enum INVCouponType {
  case couponRangeType(INVRangeCoupon)
  case couponFixType(INVFixCoupon)
}

extension INVCouponType: Equatable {
    public static func == (lhs: INVCouponType, rhs: INVCouponType) -> Bool {
        switch (lhs, rhs) {
        case (.couponRangeType(let left), .couponRangeType(let right)):
            return left == right
        case (.couponFixType(let left), .couponFixType(let right)):
            return left == right
        default:
            return false
        }
    }
}

extension INVCouponType {
    init?(from grpcType: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_BookBuilding.OneOf_Type?) {
        guard let grpcType = grpcType else { return nil }
        switch grpcType {
        case .couponFixType(let fixCoupon):
            self = .couponFixType(INVFixCoupon(from: fixCoupon))
        case .couponRangeType(let rangeCoupon):
            self = .couponRangeType(INVRangeCoupon(from: rangeCoupon))
        }
    }
}
