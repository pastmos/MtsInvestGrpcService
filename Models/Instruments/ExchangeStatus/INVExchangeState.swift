//
//  INVExchangeState.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public enum INVExchangeState {
    case open, closed
    case UNRECOGNIZED(Int)
}

extension INVExchangeState {
    init(from grpcModel: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_ExchangeState) {
        switch grpcModel {
        case .open: self = .open
        case .closed: self = .closed
        case .UNRECOGNIZED(let value): self = .UNRECOGNIZED(value)
        }
    }
}
