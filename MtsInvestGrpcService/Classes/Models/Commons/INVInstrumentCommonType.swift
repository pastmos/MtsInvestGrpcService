//
//  InstrumentCommonType.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 19.07.2021.
//

public enum INVInstrumentCommonType {
    case other
    case stock
    case bond
    case etf
    case currency
    case foreignStock
    case foreginBond
    
    init(from instrumentType: GrpcInstrumentCommonType) {
        switch instrumentType {
        case .other:
            self = .other
        case .stock:
            self = .stock
        case .bond:
            self = .bond
        case .etf:
            self = .etf
        case .currency:
            self = .currency
        case .foreignStock:
            self = .foreignStock
        case .foreignBond:
            self = .foreginBond
        default:
            self = .other
        }
    }
}
