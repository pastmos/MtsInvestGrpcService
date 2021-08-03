//
//  BrokerPositionLifecycleStage.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 19.07.2021.
//

public enum INVBrokerPositionLifecycleStage {
    /// выдана
    case issued
    /// в исполнении
    case inProgress
    /// погашена
    case maturity
    case UNRECOGNIZED(Int)
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .issued
        case 1: self = .inProgress
        case 2: self = .maturity
        default: self = .UNRECOGNIZED(rawValue)
        }
    }
}
