//
//  INVOperationID.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

public enum INVOperationID {
    case orderID(Int)
    case userOrderID(Int)
}

extension INVOperationID {
    init(from grpcModel: Ru_Mts_Trading_Trade_CancelOperationIntent.OneOf_OperationID) {
        switch grpcModel {
        case .orderID(let id):
            self = .orderID(Int(id))
        case .userOrderID(let id):
            self = .userOrderID(Int(id))
        }
    }
}

extension INVOperationID {
    func grpcModel() -> Ru_Mts_Trading_Trade_CancelOperationIntent.OneOf_OperationID {
        switch self {
        case .orderID(let id):
            return .orderID(UInt64(id))
        case .userOrderID(let id):
            return .userOrderID(UInt64(id))
        }
    }
}
