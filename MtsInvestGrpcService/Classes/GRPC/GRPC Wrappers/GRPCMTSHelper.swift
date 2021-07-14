//
//  GRPCMTSHelper.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 13.07.2021.
//

import Foundation
import GRPC

struct GRPCMTSHelper {
    private init(){}
    
    static func convertStatusCodeToAppError(_ statusCode: GRPCStatus.Code) -> AppError? {
        switch statusCode {
        case .ok,
             .cancelled,
             .unknown,
             .deadlineExceeded:
            return nil
        case .unauthenticated:
            return .authAPIError
        case .invalidArgument,
             .notFound,
             .alreadyExists,
             .permissionDenied,
             .resourceExhausted,
             .failedPrecondition,
             .aborted,
             .outOfRange,
             .unimplemented,
             .internalError,
             .unavailable,
             .dataLoss,
             .doNotUse:
            return .serialization
        }
    }
}
