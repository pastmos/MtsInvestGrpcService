//
//  INVExchangeStatus.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

public struct INVExchangeStatus {
    ///статус биржи
    let exchangeState: INVExchangeState
    ///время до смены статуса в мсек.
    let millisecondsToStatusChange: Int
}

extension INVExchangeStatus {
    init(from grpcModel: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse) {
        self.exchangeState = INVExchangeState(from: grpcModel.exchangeState)
        self.millisecondsToStatusChange = Int(grpcModel.millisecondsToStatusChange)
    }
}
