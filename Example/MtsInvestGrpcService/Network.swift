//
//  Network.swift
//  MtsInvestGrpcService_Example
//
//  Created by Юрий Султанов on 20.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import MtsInvestGrpcService

final class NetworkService {
    static let instance = NetworkService()
    
    private init() { }
    
    let grpc = MtsGRPCClass(
        host: "broker.sistema-capital.com",
        port: 9000)
}


// broker.sistema-capital.com:9000
// broker.sistema-capital.com:9010
