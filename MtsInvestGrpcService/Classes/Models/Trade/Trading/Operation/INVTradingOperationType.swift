//
//  INVTradingOperationType.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 02.08.2021.
//

public enum INVTradingOperationType: Equatable {
    case buy, sell, cancel
    case UNRECOGNIZED(Int)
}

extension INVTradingOperationType {
    init(from grpcModel: Ru_Mts_Trading_Trade_OperationType) {
        switch grpcModel {
        case .buy: self = .buy
        case .sell: self = .sell
        case .cancel: self = .cancel
        case .UNRECOGNIZED(let value): self = .UNRECOGNIZED(value)
        }
    }
}

extension INVTradingOperationType {
    func grpcModel() -> Ru_Mts_Trading_Trade_OperationType {
        switch self {
        case .buy:
            return .buy
        case .cancel:
            return .cancel
        case .sell:
            return .sell
        case .UNRECOGNIZED(let code):
            return .UNRECOGNIZED(code)
        }
    }
}


