//
//  BrokerPositionGroup.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 19.07.2021.
//

public enum INVBrokerPositionGroup {
    case stock, bond, currency, other
    case UNRECOGNIZED(Int)
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .stock
        case 1: self = .bond
        case 2: self = .currency
        case 3: self = .other
        default: self = .UNRECOGNIZED(rawValue)
        }
    }
}
