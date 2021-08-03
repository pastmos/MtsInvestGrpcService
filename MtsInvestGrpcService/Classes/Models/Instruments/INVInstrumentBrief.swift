//
//  INVListInstrument.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 23.07.2021.
//

public struct INVInstrumentBrief {
    let instrumentID: String
    let description: String
    let price: Double
    let currency: INVCurrency
    let dayChange: Double
    let weekChange: Double
    let monthChange: Double
    let threeMonthsChange: Double
    let yearChange: Double
    let threeYearsChange: Double
    let allTimeChange: Double
    let lotSize: Int
    let maturityDate: Date?
    let commonType: INVInstrumentCommonType
}

extension INVInstrumentBrief: Equatable {
    
}

extension INVInstrumentBrief {
    init(from grpcInstrument: InstrumentBrief) {
        self.instrumentID = grpcInstrument.instrumentID
        self.description = grpcInstrument.description_p
        self.price = grpcInstrument.price.toDouble()
        self.currency = INVCurrency(from: grpcInstrument.currency)
        self.dayChange = grpcInstrument.dayChange.toDouble()
        self.weekChange = grpcInstrument.weekChange.toDouble()
        self.monthChange = grpcInstrument.monthChange.toDouble()
        self.threeMonthsChange = grpcInstrument.threeMonthsChange.toDouble()
        self.yearChange = grpcInstrument.yearChange.toDouble()
        self.threeYearsChange = grpcInstrument.threeMonthsChange.toDouble()
        self.allTimeChange = grpcInstrument.allTimeChange.toDouble()
        self.lotSize = Int(grpcInstrument.lotSize)
        self.maturityDate = grpcInstrument.maturityDate.toDate()
        self.commonType = INVInstrumentCommonType(from: grpcInstrument.commonType)
    }
}
