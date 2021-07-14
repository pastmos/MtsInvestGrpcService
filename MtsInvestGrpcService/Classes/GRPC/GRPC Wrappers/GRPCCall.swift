//
//  GRPCCall.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 13.07.2021.
//

import Foundation

final class GRPCCall<Response, GRPCResponse, Request> {
    private init(){}
    
    /// - Parameters:
    ///   - request: параметры необходимые для вызова
    ///   - metadata: метада запроса. По умолчанию имеет значение .authorization() — содержит внутри API токен
    ///   - builder: создание GRPC запроса. _request_ — параметры запроса,  _metadata_ — метадата для запроса, _completion_ — замыкание, захватывающее результат вызова
    ///   - responseMap: замыкание, позволяющее произвести преобразования над полученным ответом. Можно передать nil. **Работает не на главной очереди**
    ///   - result: замыкание, возвращающее результат выполения запроса в виде _Result<Response, AppError>_
    static func execute(
        request: Request,
        metadata: Metadata = .authorization(),
        builder: @escaping (
            _ request: Request,
            _ metadata: Metadata,
            _ completion: @escaping (GRPCResponse?, CallResult) -> Void
        ) throws -> Void,
        responseMap: ((GRPCResponse?) -> Response?)?,
        result: @escaping (Result<Response, AppError>) -> Void
    ) {
        do {
            try builder(request, metadata, { response, callResult in
                print("******* GRPCCall<\(Request.self)> received: \(String(describing: response)), callResult = \(callResult)")

                if callResult.statusCode == .ok {
                    if let responseObject = response {
                        guard let mapResult = responseMap?(responseObject) else {
                            DispatchQueue.main.async {
                                result(.success(responseObject as! Response))
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            result(.success(mapResult))
                        }
                    } else {
                        DispatchQueue.main.async {
                            result(.failure(.serialization))
                        }
                    }
                } else {
                    let error = GRPCMTSHelper.convertStatusCodeToAppError(callResult.statusCode) ?? .serialization
                    DispatchQueue.main.async {
                        result(.failure(error))
                    }
                }
            })
        } catch {
            result(.failure(.serialization))
        }
    }
}
