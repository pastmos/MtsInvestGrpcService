//
//  INVTradingWatchRequest.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 02.08.2021.
//

public struct INVTradingWatchRequest {
    let type: INVTradingOperationType
    let quantity: Int
    let securityName: String
}

extension INVTradingWatchRequest {
    init(from grpcModel: Ru_Mts_Trading_Trade_WatchRequest) {
        self.type = .init(from: grpcModel.type)
        self.quantity = Int(grpcModel.quantity)
        self.securityName = grpcModel.securityName
    }
    
    public init(type: INVTradingOperationType = .buy, quantity: Int = 0, instrumentId: String) {
        self.type = type
        self.quantity = quantity
        self.securityName = instrumentId
    }
}

extension INVTradingWatchRequest {
    func grpcModel() -> Ru_Mts_Trading_Trade_WatchRequest {
        Ru_Mts_Trading_Trade_WatchRequest
            .with {
                $0.type = type.grpcModel()
                $0.quantity = UInt32(quantity)
                $0.securityName = securityName
            }
    }
}
