//
//  Currency.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 19.07.2021.
//

public enum Currency: String {
    case multi = ""
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    
    init(grpcCurrency: GrpcCurrency) {
        switch grpcCurrency.value {
        case Currency.rub.rawValue:
            self = .rub
        case Currency.eur.rawValue:
            self = .eur
        case Currency.usd.rawValue:
            self = .usd
        default:
            self = .multi
        }
    }
}
