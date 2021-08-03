//
//  INVTradingWatchPrice.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 02.08.2021.
//

public struct INVTradingWatchPrice {
    let type: INVTradingOperationType
    let securityName: String
    let quantity: Int
    let price: Double
    let bid: Double
    let ask: Double
}

extension INVTradingWatchPrice: Equatable {
    public static func == (lhs: INVTradingWatchPrice, rhs: INVTradingWatchPrice) -> Bool {
        lhs.type == rhs.type
            && lhs.securityName == rhs.securityName
            && lhs.quantity == rhs.quantity
    }
}

extension INVTradingWatchPrice {
    init(from grpcModel: Ru_Mts_Trading_Trade_WatchPrice) {
        self.type = .init(from: grpcModel.type)
        self.securityName = grpcModel.securityName
        self.quantity = Int(grpcModel.quantity)
        self.price = grpcModel.price.toDouble()
        self.bid = grpcModel.bid.toDouble()
        self.ask = grpcModel.bid.toDouble()
    }
}

extension INVTradingWatchPrice {
    func grpcModel() -> Ru_Mts_Trading_Trade_WatchPrice {
        Ru_Mts_Trading_Trade_WatchPrice
            .with {
                $0.type = type.grpcModel()
                $0.securityName = securityName
                $0.quantity = UInt64(quantity)
                $0.price = price.toTradePrice()
                $0.bid = bid.toTradePrice()
                $0.ask = ask.toTradePrice()
            }
    }
}
