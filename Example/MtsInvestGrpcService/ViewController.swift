//
//  ViewController.swift
//  MtsInvestGrpcService
//
//  Created by Sergey Panov on 02.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import NIO
import GRPC
import SwiftProtobuf
//import MtsInvestGrpcService

final class ViewController: UIViewController {
    typealias ServiceClient = Ru_Mts_Trading_Pub_User_UserPublicServiceClient
//    var grpcService = MtsGRPCClass(token: "a34a60db-8bc0-4f1d-b16e-7e825e524dc4")
    
    @IBOutlet private var tokenTextField: UITextField!
    @IBAction private func refresh() {
        guard let token = tokenTextField.text else { return }
        self.token = token
//        let grpcService = MtsGRPCClass(token: token)
        makeStream(to: "broker.sistema-capital.com", port: 9010)
    }
    
    private var token = ""
    private var service: ServiceClient?
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var channel: ClientConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func makeStream(
        to host: String,
        port: Int) {
        let configuration = ClientConnection.Configuration.default(
            target: .hostAndPort(host, port),
            eventLoopGroup: group)
        let channel = ClientConnection(configuration: configuration)
//            .insecure(group: group)
//            .connect(
//                host: host,
//                port: port)
            
        var callOptions = CallOptions()
        callOptions.customMetadata.add(
            name: "authorization",
            value: token)
        
        let service = ServiceClient(
            channel: channel,
            defaultCallOptions: callOptions)
        DispatchQueue.global().async {
            let some = try? service
                .getMtsbDialog(Google_Protobuf_Empty())
                .response
                .wait()
            print(some)
//                .whenCompleteBlocking(onto: .main) { result in
//                    switch result {
//                    case .success(let model):
//                        print(model)
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//            }
        }
        
//        stream.status.whenSuccess{ status in
//            print(status)
//        }
//
//        stream.status.whenFailure { error in
//            print(error.localizedDescription)
//        }
    }
}

