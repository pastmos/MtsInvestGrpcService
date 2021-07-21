//
//  ViewController.swift
//  MtsInvestGrpcService
//
//  Created by Sergey Panov on 02.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MtsInvestGrpcService

final class ViewController: UIViewController {
    @IBOutlet private var tokenTextField: UITextField!
    @IBAction private func refresh() {
        guard let token = tokenTextField.text else { return }
        grpcClass
            .setToken(token)
        fetchPortfolio()
    }
    
    @IBAction private func stop() {
        grpcClass.unsubscribe(self, from: .brokerPorfolio)
    }
    
    private lazy var grpcClass = NetworkService.instance.grpc
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
