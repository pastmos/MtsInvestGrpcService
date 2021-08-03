//
//  AnyService.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 29.07.2021.
//

import GRPC

protocol AnyService {
    func parseStatus(from result: Result<GRPCStatus, Error>) -> INVError?
}

extension AnyService {
    func parseStatus(from result: Result<GRPCStatus, Error>) -> INVError? {
        switch result {
        case .success(let status):
            switch status.code {
            case .ok,
                 .cancelled,
                 .unknown,
                 .deadlineExceeded:
                return nil
            case .unavailable:
                return .unavailable
            default:
                return INVError(from: status.code)
            }
            
        case .failure(let error):
            return .error(error.localizedDescription)
        }
    }
}
