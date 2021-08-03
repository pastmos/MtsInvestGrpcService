//
//  INVInstrumentState.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 27.07.2021.
//

enum INVInstrumentState {
    ///бумага не активна, используется как дефолтное значение при добавлении новых значений статусов
    case notActive
    ///бумага активна (торгуется на бирже)
    case active
    ///бумага погашена (только для облиг)
    case maturity
    ///бумага заблокирована для торгов
    case blocked
    ///прием заявок еще не начат
    case preBookBuilding
    ///идет прием заявок
    case bookBuilding
    ///идет исполнение заявок (размещение)
    case allocating
    
    case UNRECOGNIZED(Int)
    
    init(from grpcInstrumentState: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_Instrument.InstrumentState) {
        switch grpcInstrumentState {
        case .active: self = .active
        case .allocating: self = .allocating
        case .blocked: self = .blocked
        case .bookBuilding: self = .bookBuilding
        case .maturity: self = .maturity
        case .notActive: self = .notActive
        case .preBookBuilding: self = .preBookBuilding
        case .UNRECOGNIZED(let value): self = .UNRECOGNIZED(value)
        }
    }
    
}
