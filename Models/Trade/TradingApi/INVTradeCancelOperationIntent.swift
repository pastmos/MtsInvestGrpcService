//
//  INVTradeCancelOperationIntent.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

public struct INVTradeCancelOperationIntent {
    let operationID: INVOperationID?
    let orderID: Int
    let userOrderID: Int
}

extension INVTradeCancelOperationIntent {
    init(from grpcModel: Ru_Mts_Trading_Trade_CancelOperationIntent) {
        if let operationID = grpcModel.operationID {
            self.operationID = INVOperationID(from: operationID)
        } else {
            self.operationID = nil
        }
        self.orderID = Int(grpcModel.orderID)
        self.userOrderID = Int(grpcModel.userOrderID)
    }
}

extension INVTradeCancelOperationIntent {
    func grpcModel() -> Ru_Mts_Trading_Trade_CancelOperationIntent {
        return Ru_Mts_Trading_Trade_CancelOperationIntent
            .with {
                $0.operationID = operationID?.grpcModel()
                $0.orderID = UInt64(orderID)
                $0.userOrderID = UInt64(userOrderID)
            }
    }
}
