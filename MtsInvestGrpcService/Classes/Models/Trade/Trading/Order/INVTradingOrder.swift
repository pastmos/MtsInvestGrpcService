//
//  INVTradingOrder.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 02.08.2021.
//

public struct INVTradingOrder {
    /// real order id
    public let orderID: Int
    /// LocalId is field that could be any, and may be setted by the API's user
    public let localID: Int
    public let type: INVTradingOperationType
    /// security name
    public let securityName: String
    /// limit price
    public let price: Double
    /// current status
    public let status: INVTradingOrderStatus
    /// Exists only when order is PartiallyFilled or Closed, otherwise it is zero
    public let realPrice: Double
    /// lots
    public let lots: Int
    /// message associated with order
    public let message: String
    /// amount of excuted lots at the moment
    public let executedLots: Int
    /// sends once after hide
    public let hidden: Bool
}

extension INVTradingOrder: Equatable {
    public static func == (lhs: INVTradingOrder, rhs: INVTradingOrder) -> Bool {
        lhs.orderID == rhs.orderID
            && lhs.localID == rhs.orderID
    }
}

extension INVTradingOrder {
    init(from grpcModel: Ru_Mts_Trading_Trade_Order) {
        self.orderID = Int(grpcModel.orderID)
        self.localID = Int(grpcModel.localID)
        self.type = .init(from: grpcModel.type)
        self.securityName = grpcModel.securityName
        self.price = grpcModel.price
        self.status = .init(from: grpcModel.status)
        self.realPrice = grpcModel.realPrice.toDouble()
        self.lots = Int(grpcModel.lots)
        self.message = grpcModel.message
        self.executedLots = Int(grpcModel.executedLots)
        self.hidden = grpcModel.hidden
    }
}

extension INVTradingOrder {
    func grpcModel() -> Ru_Mts_Trading_Trade_Order {
        Ru_Mts_Trading_Trade_Order.with {
            $0.orderID = UInt64(orderID)
            $0.localID = UInt64(localID)
            $0.type = type.grpcModel()
            $0.securityName = securityName
            $0.price = price
            $0.status = status.grpcModel()
            $0.realPrice = realPrice.toTradePrice()
            $0.lots = UInt64(lots)
            $0.message = message
            $0.executedLots = UInt64(executedLots)
            $0.hidden = hidden
        }
    }
}
