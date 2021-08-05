//
//  Currency.swift
//  FinService
//
//  Created by Дмитрий on 03.10.17.
//  Copyright © 2017 MTS IT. All rights reserved.
//

import UIKit

enum Currency: String {
    case multi = ""
    case rub = "RUB"
    case rur = "RUR"
    case usd = "USD"
    case eur = "EUR"
    
    var sign: String {
        return "Currency.\(rawValue).Sign".localized
    }
    
    init(portfolioCurrency: Int) {
        switch portfolioCurrency {
        case 0: self = .rub
        case 1: self = .usd
        case 2: self = .rur
        case 3: self = .eur
        default:
            self = .multi
        }
    }
    
    init(currencyEnum: CurrencyEnum) {
        switch currencyEnum {
        case .ALL_IN_RUB,
             .RUB:
            self = .rub
        case .USD:
            self = .usd
        }
    }
	
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
    
    init(sign: String) {
        switch sign {
        case "₽":
            self = .rub
        case "$":
            self = .usd
        case "€":
            self = .eur
        default:
            self = .multi
        }
    }
    
    var currencyCharacter: String {
        switch self {
        case .rub,
             .rur:
            return R.string.localizable.currencyRUBSign()
        case .usd:
            return R.string.localizable.currencyUSDSign()
        case .eur:
            return R.string.localizable.currencyEURSign()
        default:
            return ""
        }
    }
    
    var name: String {
        switch self {
        case .multi:
            return ""
        case .rub:
            return R.string.localizable.currencyRUBName()
        case .rur:
            return R.string.localizable.currencyRURName()
        case .usd:
            return R.string.localizable.currencyUSDName()
        case .eur:
            return R.string.localizable.currencyEURName()
        }
    }
    
    var feedImage: UIImage? {
        switch self {
        case .multi:
            return nil
        case .rub,
             .rur:
            return R.image.icRub_grey()
        case .usd:
            return R.image.icUsd_grey()
        case .eur:
            return R.image.icEur_grey()
        }
    }
	
	var countryImage: UIImage? {
		switch self {
		case .eur:
			return R.image.icEuFlag()
		case .rub:
			return R.image.icRfFlag()
		case .usd:
			return R.image.icUsFlag()
		default: return nil
		}
	}
    
    var nameForCount: String {
        switch self {
        case .multi:
            return ""
        case .rub:
            return R.string.localizable.currencyRUBNameCount()
        case .rur:
            return R.string.localizable.currencyRURNameCount()
        case .usd:
            return R.string.localizable.currencyUSDNameCount()
        case .eur:
            return R.string.localizable.currencyEURNameCount()
        }
    }
    
    var fullName: String {
        switch self {
        case .multi:
            return ""
        case .rub:
            return R.string.localizable.currencyRUBFullName()
        case .rur:
            return R.string.localizable.currencyRURFullName()
        case .usd:
            return R.string.localizable.currencyUSDFullName()
        case .eur:
            return R.string.localizable.currencyEURFullName()
        }
    }
	
	var sortIndex: Int {
		switch self {
		case .rub:
			return 1
		case .usd:
			return 2
		case .eur:
			return 3
		case .rur:
			return 4
		case .multi:
			return 5
		}
	}
	
	static func <(lhs: Currency, rhs: Currency) -> Bool {
		return lhs.sortIndex < rhs.sortIndex
	}
	
}
