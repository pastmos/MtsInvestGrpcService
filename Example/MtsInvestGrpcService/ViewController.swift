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
        grpcClass.closeSteam()
    }
    
    private lazy var grpcClass = MtsGRPCClass(
        host: "broker.sistema-capital.com",
        port: 9010)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func fetchPortfolio() {
        grpcClass.getBrokerPortfolio { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
