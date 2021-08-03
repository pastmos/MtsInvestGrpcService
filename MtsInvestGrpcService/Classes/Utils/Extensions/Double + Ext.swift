//
//  Double + Ext.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

extension Double {
    func toTradePrice() -> Ru_Mts_Trading_Trade_Price {
        let doubleString = ("\(self)")
            .components(separatedBy: ".")
        return Ru_Mts_Trading_Trade_Price
            .with {
                $0.price = UInt64(doubleString.joined()) ?? 0
                $0.scale = UInt64(doubleString.last?.count ?? 0)
            }
    }
}
