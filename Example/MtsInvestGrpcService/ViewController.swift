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
    
    @IBAction private func someButton() {
        marketData = []
        grpcClass.setMDPeriod(.day)
    }
    
    private lazy var grpcClass = NetworkService.instance.grpc
    
    private var marketData = [INVMarketDataResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// дозагрузка точек графика при обновлении, предварительная подписка обязательна
    private func updateMD() {
        let request = INVMDForPeriodRequest(
            instrumentID: "LKOh",
            period: .day,
            from: marketData.last?.startTime ?? 0.0,
            to: Date().timeIntervalSince1970 * 1000)
        grpcClass.getMDForPeriod(request: request)
    }
    
    private func fetch() {
        marketData = []
        grpcClass.getIndicators(instrumentID: "LKOH") { result in
            switch result {
            case .success(let indicators):
                print(indicators)
            case .failure(let error):
                print(error)
            }
        }
        
        grpcClass.subscribeMarketData(
            self,
            instumentID: "LKOH",
            period: .day) { [weak self] result in
            switch result {
            case .success(let marketDataResponse):
                guard
                    let self = self,
                    let marketDataResponse = marketDataResponse
                else { return }
                self.marketData.append(marketDataResponse)
                print(self.marketData.count)
            case .failure(let error):
                print(error)
            }
        }
//        grpcClass.subscribeInstruments(
//            self,
//            for: ["LKOH", "SBER", "GAZP", "GMKN"]) { result in
//            switch result {
//            case .success(let instrumentBrief):
//                print(instrumentBrief)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
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
