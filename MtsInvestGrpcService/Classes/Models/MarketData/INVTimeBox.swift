//
//  INVTimeBox.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 04.08.2021.
//

public enum INVTimeBox {
    case unspecified,
         day,
         week,
         month,
         threeMonths,
         year,
         threeYears,
         allTime
    case UNRECOGNIZED(Int)
}

extension INVTimeBox {
    init(from grpcModel: Ru_Mts_Trading_Marketdata_TimeBox) {
        switch grpcModel {
        case .allTime: self = .allTime
        case .day: self = .day
        case .month: self = .month
        case .threeMonths: self = .threeMonths
        case .threeYears: self = .threeYears
        case .unspecified: self = .unspecified
        case .week: self = .week
        case .year: self = .year
        case .UNRECOGNIZED(let value): self = .UNRECOGNIZED(value)
        }
    }
}

extension INVTimeBox {
    func grpcModel() -> Ru_Mts_Trading_Marketdata_TimeBox {
        switch self {
        case .UNRECOGNIZED(let value): return .UNRECOGNIZED(value)
        case .allTime: return .allTime
        case .day: return .day
        case .month: return .month
        case .threeMonths: return .threeMonths
        case .threeYears: return .threeYears
        case .unspecified: return .unspecified
        case .week: return .week
        case .year: return .year
        }
    }
}
