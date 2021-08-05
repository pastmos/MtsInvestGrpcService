//
//  INVIndicatorsResponse.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 04.08.2021.
//

public struct INVIndicatorsResponse {
    public let open: Double
    public let dayMin: Double
    public let dayMax: Double
    public let pe: Double
    public let yearMax: Double
    public let yearMin: Double
    public let allTimeMax: Double
    public let allTimeMin: Double
}

extension INVIndicatorsResponse {
    init(from grpcModel: Ru_Mts_Trading_Marketdata_GetIndicatorsResponse) {
        self.open = Double(grpcModel.open) ?? 0.0
        self.dayMin = Double(grpcModel.dayMin) ?? 0.0
        self.dayMax = Double(grpcModel.dayMax) ?? 0.0
        self.pe = Double(grpcModel.pe) ?? 0.0
        self.yearMax = Double(grpcModel.yearMax) ?? 0.0
        self.yearMin = Double(grpcModel.yearMin) ?? 0.0
        self.allTimeMax = Double(grpcModel.allTimeMax) ?? 0.0
        self.allTimeMin = Double(grpcModel.allTimeMin) ?? 0.0
    }
}

extension INVIndicatorsResponse {
    func grpcModel() -> Ru_Mts_Trading_Marketdata_GetIndicatorsResponse {
        .with {
            $0.open = String(open)
            $0.dayMin = String(dayMin)
            $0.dayMax = String(dayMax)
            $0.pe = String(pe)
            $0.yearMax = String(yearMax)
            $0.yearMin = String(yearMin)
            $0.allTimeMax = String(allTimeMax)
            $0.allTimeMin = String(allTimeMin)
        }
    }
}
