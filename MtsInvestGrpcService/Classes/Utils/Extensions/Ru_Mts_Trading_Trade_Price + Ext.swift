//
//  Ru_Mts_Trading_Trade_Price + Ext.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

extension Ru_Mts_Trading_Trade_Price {
    func toDouble() -> Double {
        return Double(price) / pow(10.0, Double(scale))
    }
}


