//
//  INVMarketDataResponse.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 04.08.2021.
//

public struct INVMarketDataResponse: Equatable {
    public let startTime: Double
    public let value: Double
}

extension INVMarketDataResponse {
    init(from grpcModel: Ru_Mts_Trading_Marketdata_MarketDataResponse) {
        self.startTime = Double(grpcModel.startTime)
        self.value = Double(grpcModel.value) ?? 0.0
    }
}

extension INVMarketDataResponse {
    func grpcModel() -> Ru_Mts_Trading_Marketdata_MarketDataResponse {
        .with {
            $0.startTime = UInt64(self.startTime)
            $0.value = String(value)
        }
    }
}
