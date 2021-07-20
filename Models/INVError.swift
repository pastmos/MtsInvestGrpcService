//
//  INVError.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 19.07.2021.
//

import GRPC

public enum INVError: Error {
    case unauthenticated
    case error(String)
    
    init(from code: GRPCStatus.Code) {
        switch code {
        case .unauthenticated:
            self = .unauthenticated
        default:
            self = .error(code.description)
        }
    }
    
    init(from description: String) {
        self = .error(description)
    }
}

