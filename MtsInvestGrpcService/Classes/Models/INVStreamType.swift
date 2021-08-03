//
//  INVStreamType.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 20.07.2021.
//

public enum INVStreamType: CaseIterable {
    case brokerPorfolio
    case tradeOperation
    case watchSingle
    case instumentBrief
}
