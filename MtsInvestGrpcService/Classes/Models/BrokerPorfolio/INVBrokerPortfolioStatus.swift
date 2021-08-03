//
//  BrokerPortfolioStatus.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public enum INVBrokerPortfolioStatus {
    case exists, error, notExists
    case UNRECOGNIZED(Int)
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .exists
        case 1: self = .error
        case 2: self = .notExists
        default: self = .UNRECOGNIZED(rawValue)
        }
    }
}
