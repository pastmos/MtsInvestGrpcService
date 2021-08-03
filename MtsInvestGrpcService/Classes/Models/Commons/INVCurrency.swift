//
//  Currency.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 19.07.2021.
//

public enum INVCurrency: String {
    case multi = ""
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
}

extension INVCurrency {
    init(from grpcCurrency: GrpcCurrency) {
        switch grpcCurrency.value {
        case INVCurrency.rub.rawValue:
            self = .rub
        case INVCurrency.eur.rawValue:
            self = .eur
        case INVCurrency.usd.rawValue:
            self = .usd
        default:
            self = .multi
        }
    }
    
    init(from itiCurrency: Iticapital_ApiMts_Security_V1_Currency) {
        switch itiCurrency {
        case .rub:
            self = .rub
        case .eur:
            self = .eur
        case .usd:
            self = .usd
        default:
            self = .multi
        }
    }
}
