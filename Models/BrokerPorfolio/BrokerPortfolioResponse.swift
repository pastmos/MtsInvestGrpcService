//
//  BrokerPorfolioResponse.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//


public struct BrokerPortfolioResponse {
    let portfolio: BrokerPortfolio
    let positions: [BrokerPosition]
    let status: BrokerPortfolioStatus
}

extension BrokerPortfolioResponse {
    init(from grpcModel: Ru_Mts_Trading_Broker_Commons_PortfolioResponse) {
        self.portfolio = BrokerPortfolio(from: grpcModel.portfolio)
        self.positions = grpcModel.positions.map { BrokerPosition(from: $0) }
        self.status = BrokerPortfolioStatus(rawValue: grpcModel.status.rawValue)
    }
}
