//
//  INVTradeOperationIntent.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

public struct INVTradeExecuteOperationIntent {
    let operationType: INVTradeOperationType
    let securityName: String
    let lots: Double
    let price: Double
    let currencyCode: INVCurrency
    let userOrderID: UInt64
}

extension INVTradeExecuteOperationIntent {
    func grpcModel() -> Ru_Mts_Trading_Trade_ExecuteOperationIntent {
        Ru_Mts_Trading_Trade_ExecuteOperationIntent.with {
            $0.operationType = operationType.grpcModel()
            $0.securityName = securityName
            $0.lots = lots.toTradePrice()
            $0.price = price.toTradePrice()
            $0.currencyCode = GrpcCurrency.with{ $0.value = currencyCode.rawValue }
            $0.userOrderID = userOrderID
        }
    }
}




