//
//  INVTradingOrderStatus.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 02.08.2021.
//

public enum INVTradingOrderStatus {
    case pending,
         open,
         partiallyFilled,
         cancelled,
         closed,
         rejected,
         failed,
         executed,
         expired,
         UNRECOGNIZED(Int)
}

extension INVTradingOrderStatus {
    init(from grpcModel: Ru_Mts_Trading_Trade_OrderStatus) {
        switch grpcModel {
        case .pending: self = .pending
        case .open: self = .open
        case .partiallyFilled: self = .partiallyFilled
        case .cancelled: self = .cancelled
        case .closed: self = .closed
        case .rejected: self = .rejected
        case .failed: self = .failed
        case .executed: self = .executed
        case .expired: self = .expired
        case .UNRECOGNIZED(let code): self = .UNRECOGNIZED(code)
        }
    }
}

extension INVTradingOrderStatus {
    func grpcModel() -> Ru_Mts_Trading_Trade_OrderStatus {
        switch self {
        case .pending: return .pending
        case .open: return .open
        case .partiallyFilled: return .partiallyFilled
        case .cancelled: return .cancelled
        case .closed: return .closed
        case .rejected: return .rejected
        case .failed: return .failed
        case .executed: return.executed
        case .expired: return.expired
        case .UNRECOGNIZED(let code): return .UNRECOGNIZED(code)
        }
    }
}
