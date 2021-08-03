//
//  BrokerPorfolioResponse.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 16.07.2021.
//

public struct INVBrokerPortfolioResponse {
    let portfolio: INVBrokerPortfolio
    let positions: [INVBrokerPosition]
    let status: INVBrokerPortfolioStatus
}

extension INVBrokerPortfolioResponse {
    init(from grpcModel: Ru_Mts_Trading_Broker_Commons_PortfolioResponse) {
        self.portfolio = INVBrokerPortfolio(from: grpcModel.portfolio)
        self.positions = grpcModel.positions.map { INVBrokerPosition(from: $0) }
        self.status = INVBrokerPortfolioStatus(rawValue: grpcModel.status.rawValue)
    }
}

extension INVBrokerPortfolioResponse: Equatable {
    public static func == (lhs: INVBrokerPortfolioResponse, rhs: INVBrokerPortfolioResponse) -> Bool {
        lhs.portfolio.contractID == rhs.portfolio.contractID
            && lhs.portfolio.freeValue == rhs.portfolio.freeValue
            && lhs.portfolio.availableWithdrawAmount == rhs.portfolio.availableWithdrawAmount
            && lhs.portfolio.assetsValue == rhs.portfolio.assetsValue
            && lhs.portfolio.income == rhs.portfolio.income
    }
}
