//
//  ViewController0.swift
//  MtsInvestGrpcService_Example
//
//  Created by Юрий Султанов on 20.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MtsInvestGrpcService

class ViewController0: UIViewController {
    private lazy var grpcClass = NetworkService.instance.grpc

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPortfolio()
    }
    
    private func fetchPortfolio() {
        grpcClass.subscribeBrokerPorfolio(self) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                if case .unauthenticated = error {
                    print(error)
                    // stashed token -> set new
                    //                    grpcClass.setToken("")
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    deinit {
        grpcClass.unsubscribe(
            self,
            from: INVStreamType.allCases)
    }
}
