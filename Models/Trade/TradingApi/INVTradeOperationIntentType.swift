//
//  INVTradeOperationIntentType.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

public enum INVTradeOperationIntentType {
    case execute(INVTradeExecuteOperationIntent)
    case cancel(INVTradeCancelOperationIntent)
}

extension INVTradeOperationIntentType {
    func grpcModel() -> Ru_Mts_Trading_Trade_OperationIntent.OneOf_Intent {
        switch self {
        case .execute(let executeOperationIntent):
            return .execute(executeOperationIntent.grpcModel())
        case .cancel(let cancelOperationIntent):
            return .cancel(cancelOperationIntent.grpcModel())
        }
    }
}
