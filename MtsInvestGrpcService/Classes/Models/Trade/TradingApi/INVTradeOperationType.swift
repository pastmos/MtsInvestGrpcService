//
//  INVTradeOperationIntentType.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

public enum INVTradeOperationType {
    case buy, sell
    case UNRECOGNIZED(Int)
}

extension INVTradeOperationType {
    init(from grpcModel: Ru_Mts_Trading_Trade_OperationIntentType) {
        switch grpcModel {
        case .buyOperation: self = .buy
        case .sellOperation: self = .sell
        case .UNRECOGNIZED(let value): self = .UNRECOGNIZED(value)
        }
    }
}

extension INVTradeOperationType {
    func grpcModel() -> Ru_Mts_Trading_Trade_OperationIntentType {
        switch self {
        case .buy: return .buyOperation
        case .sell: return .sellOperation
        case .UNRECOGNIZED(let value): return .UNRECOGNIZED(value)
        }
    }
}
