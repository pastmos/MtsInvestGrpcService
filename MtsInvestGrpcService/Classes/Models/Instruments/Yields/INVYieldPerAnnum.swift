//
//  INVYieldPerAnnum.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public enum INVYieldPerAnnum {
  ///точное значение (например, для фиксированного купона)
  case yieldPerAnnumValue(Double)
  ///диапазон (например, для диапазона купона)
  case yieldPerAnnumRange(INVYieldPerAnnumRange)
}

extension INVYieldPerAnnum: Equatable {
    public static func ==(lhs: INVYieldPerAnnum, rhs: INVYieldPerAnnum) -> Bool {
      switch (lhs, rhs) {
      case (.yieldPerAnnumValue(let left), .yieldPerAnnumValue(let right)):
          return left == right
      case (.yieldPerAnnumRange(let left), .yieldPerAnnumRange(let right)):
          return left == right
      default: return false
      }
    }
}

extension INVYieldPerAnnum {
    init?(from grpcYieldPerAnnum: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_BookBuilding.OneOf_YieldPerAnnum?) {
        guard let grpcYieldPerAnnum = grpcYieldPerAnnum else { return nil }
        switch grpcYieldPerAnnum {
        case .yieldPerAnnumValue(let decimal):
            self = .yieldPerAnnumValue(Double(decimal.value) ?? 0.0)
        case .yieldPerAnnumRange(let range):
            self = .yieldPerAnnumRange(INVYieldPerAnnumRange(from: range))
        }
    }
}
