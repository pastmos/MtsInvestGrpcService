//
//  IticapitalApiMtsTypeFloat + Ext.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 23.07.2021.
//

extension Iticapital_ApiMts_Type_Float {
    func toDouble() -> Double {
        return Double(value) / pow(10.0, Double(scale))
    }
}
