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
        fetch()
//        fetchPortfolio()
    }
    
    @IBAction private func stop() {
        grpcClass.unsubscribe(self, from: INVStreamType.allCases)
    }
    
    private lazy var grpcClass = NetworkService.instance.grpc
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func fetch() {
        grpcClass.subscribeInstruments(
            self,
            for: ["LKOH", "SBER", "GAZP", "GMKN"]) { result in
            switch result {
            case .success(let instrumentBrief):
                print(instrumentBrief)
            case .failure(let error):
                print(error)
            }
        }
        
        
//        grpcClass.getInstrumentsList { result in
//            switch result {
//            case .success(let instruments):
//                print(instruments.count)
//            case .failure(let error):
//                print(error.localizedDescription)
//                if case .unauthenticated = error {
//                    // stashed token -> update -> set new
//                    // grpcClass.setToken("")
//                }
//            }
//        }
//        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
//            self.grpcClass.getInstrumet(instrumentID: "LKOH") { result in
//                switch result {
//                case .success(let instrument):
//                    print(instrument)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//
//        DispatchQueue.global().asyncAfter(deadline: .now() + 4) {
//            self.grpcClass.getExchangeStatus(instrumentID: "LKOH") { result in
//                switch result {
//                case .success(let exchangeStatus):
//                    print(exchangeStatus)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        grpcClass.subscribeTradeOperation(self) { result in
//            switch result {
//            case .success(let order):
//                print(order)
//            case .failure(let error):
//                if case .unauthenticated = error {
//                    /* update token */
//                }
//                print(error)
//            }
//        }
//
//        let request = INVTradingWatchRequest(instrumentId: "LKOH")
//        grpcClass.subscribeWatchSinglePrice(
//            self,
//            request: request) { result in
//            switch result {
//            case .success(let watchPrice):
//                print(watchPrice)
//            case .failure(let error):
//                if case .unauthenticated = error {
//                    /* update token */
//                }
//                print(error)
//            }
//        }
//        grpcClass.subscribeBrokerPorfolio(self) { result in
//            switch result {
//            case .success(let response):
//                print(response)
//            case .failure(let error):
//                if case .unauthenticated = error {
//                    print(error)
//                    // stashed token -> set new
//                    //                    grpcClass.setToken("")
//                }
//            }
//        }
    }
}
