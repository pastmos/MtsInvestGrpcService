//
//  File.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 20.07.2021.
//

public enum StreamType {
    case brokerPorfolio
    
    var responseType: Any {
        switch self {
        case .brokerPorfolio:
            return BrokerPortfolioResponse.self
        }
    }
}
