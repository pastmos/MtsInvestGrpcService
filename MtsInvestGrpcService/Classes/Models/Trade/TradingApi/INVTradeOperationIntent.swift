//
//  INVTradeOperationIntent.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

public struct INVTradeOperationIntent {
    let intent: INVTradeOperationIntentType?
    let execute: INVTradeExecuteOperationIntent
    let cancel: INVTradeCancelOperationIntent
}

extension INVTradeOperationIntent {
    func grpcModel() -> Ru_Mts_Trading_Trade_OperationIntent {
        return Ru_Mts_Trading_Trade_OperationIntent
            .with {
                if let intent = intent {
                    $0.intent = intent.grpcModel()
                }
                $0.execute = execute.grpcModel()
                $0.cancel = cancel.grpcModel()
            }
    }
}

