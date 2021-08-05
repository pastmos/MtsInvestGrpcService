//
//  TradingOperation.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 02.08.2021.
//

public struct INVTradingOperation {
    public let type: INVTradingOperationType
    /// how many do you want to buy/sell?
    public let quantity: Int
    /// security name
    public let securityName: String
    /// only for cancel operation
    public let orderID: Int
    /// this field will help you with order's context
    public let localID: Int
    /// limit price
    public let price: Double
    public let priceValue: Double
}

extension INVTradingOperation {
    init(from grpcModel: Ru_Mts_Trading_Trade_TradingOperation) {
        self.type = .init(from: grpcModel.type)
        self.quantity = Int(grpcModel.quantity)
        self.securityName = grpcModel.securityName
        self.orderID = Int(grpcModel.orderID)
        self.localID = Int(grpcModel.localID)
        self.price = grpcModel.price
        self.priceValue = grpcModel.priceValue.toDouble()
    }
}

extension INVTradingOperation {
    func grpcModel() -> Ru_Mts_Trading_Trade_TradingOperation {
        Ru_Mts_Trading_Trade_TradingOperation
            .with {
                $0.type = type.grpcModel()
                $0.quantity = UInt32(quantity)
                $0.securityName = securityName
                $0.orderID = UInt64(orderID)
                $0.localID = UInt64(localID)
                $0.price = price
                $0.priceValue = priceValue.toTradePrice()
            }
    }
}
