//
//  INVMDForPeriodRequest.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 04.08.2021.
//

public struct INVMDForPeriodRequest {
    public let instrumentID: String
    public let timeBox: INVTimeBox
    public let start: Double
    public let end: Double
}

extension INVMDForPeriodRequest {
    init(from grpcModel: Ru_Mts_Trading_Marketdata_GetMDForPeriodRequest) {
        self.instrumentID = grpcModel.instrumentID
        self.timeBox = .init(from: grpcModel.timeBox)
        self.start = Double(grpcModel.start)
        self.end = Double(grpcModel.end)
    }
    
    public init(instrumentID: String, period: INVTimeBox, from: Double, to: Double) {
        self.init(instrumentID: instrumentID, timeBox: period, start: from, end: to)
    }
}

extension INVMDForPeriodRequest {
    func grpcModel() -> Ru_Mts_Trading_Marketdata_GetMDForPeriodRequest {
        .with {
            $0.instrumentID = instrumentID
            $0.timeBox = timeBox.grpcModel()
            $0.start = UInt64(start)
            $0.end = UInt64(end)
        }
    }
}
