//
//  INVYieldPerAnnumRange.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVYieldPerAnnumRange {
    var min: Double
    var max: Double
}

extension INVYieldPerAnnumRange: Equatable { }

extension INVYieldPerAnnumRange {
    init(from grpcModel: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_BookBuilding.YieldPerAnnumRange) {
        self.min = Double(grpcModel.min.value) ?? 0.0
        self.max = Double(grpcModel.max.value) ?? 0.0
    }
}
