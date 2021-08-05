//
//  INVListInstrument.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 23.07.2021.
//

public struct INVInstrumentBrief {
    public let instrumentID: String
    public let description: String
    public let price: Double
    public let currency: INVCurrency
    public let dayChange: Double
    public let weekChange: Double
    public let monthChange: Double
    public let threeMonthsChange: Double
    public let yearChange: Double
    public let threeYearsChange: Double
    public let allTimeChange: Double
    public let lotSize: Int
    public let maturityDate: Date?
    public let commonType: INVInstrumentCommonType
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
