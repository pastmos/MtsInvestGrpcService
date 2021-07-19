//
//  BrokerPorfolioStatus.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public enum BrokerPorfolioStatus: Int {
    case exists, error, notExists
}

/*
 enum Ru_Mts_Trading_Broker_Commons_PortfolioStatus: SwiftProtobuf.Enum {
     typealias RawValue = Int
     case exists // = 0
     case error // = 1
     case notExists // = 2
     case UNRECOGNIZED(Int)
     
     init() {
         self = .exists
     }
     
     init?(rawValue: Int) {
         switch rawValue {
         case 0: self = .exists
         case 1: self = .error
         case 2: self = .notExists
         default: self = .UNRECOGNIZED(rawValue)
         }
     }
     
     var rawValue: Int {
         switch self {
         case .exists: return 0
         case .error: return 1
         case .notExists: return 2
         case .UNRECOGNIZED(let i): return i
         }
     }
     
 }
 */
