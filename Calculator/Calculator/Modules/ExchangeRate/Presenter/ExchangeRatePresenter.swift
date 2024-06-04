//
//  ExchangeRatePresenter.swift
//  Calculator
//
//  Created by Kenny on 3/06/24.
//

import UIKit

class ExchangeRatePresenter: ObservableObject, ExchangeRatePresenterProtocol {

    @Published var buyRate: String = ""
    @Published var sellRate: String = ""
    @Published var originAmount: String = "" {
            didSet {
                calculateDestinationAmount()
            }
        }
    @Published var destinationAmount: String = ""
    @Published var sourceCurrency: String = Constants.USD+"44aa"
    @Published var destinationCurrency: String = Constants.PEN
    @Published var lblSource: String = Constants.DOLAR
    @Published var lblDestionation: String = Constants.SOL
    @Published var showAlert = false

    
    var usdAmount = 0.0;
    var penAmount = 0.0;
    var interactor: ExchangeRateInteractorProtocol?
    var router: (any ExchangeRateRouterProtocol)?
    var swap = false

    func loadExchangeRates() {
        getUSD()
        getPEN()
    }

    func swapCurrencies() {
        let tempCurrency = sourceCurrency
        sourceCurrency = destinationCurrency
        destinationCurrency = tempCurrency
        calculateDestinationAmount()
        setupLabel()
    }

    func getUSD() {
        interactor?.getRates(currency: sourceCurrency)
    }
    
    func getPEN(){
        interactor?.getRates(currency: destinationCurrency)
    }

    func didFetchRates(_ rates: ConversionRates?,_ currency: String) {
        if sourceCurrency == currency{
            self.sellRate = "\(rates?.PEN ?? 0)"
            self.buyRate = String(format: "%.4f", (rates?.PEN ?? 0) + 0.136)
            penAmount = rates?.PEN ?? 0
        }else{
            usdAmount = rates?.USD ?? 0
        }
    }
    
    private func setupLabel(){
        lblSource = swap ? Constants.DOLAR : Constants.SOL
        lblDestionation = swap ? Constants.SOL : Constants.DOLAR
        swap = !swap
    }

    func calculateDestinationAmount() {
        DispatchQueue.main.async {
            guard let amount = Double(self.originAmount) else {
                self.destinationAmount = ""
                return
            }
            
            let rate = self.sourceCurrency == "USD" ? Double(self.penAmount) : Double(self.usdAmount)
            let convertedAmount = amount * rate
            self.destinationAmount = convertedAmount.formattedToThreeDecimals()
        }
    }
    
    func didFailToGetRates(_ error: Error) {
        self.showAlert = true
    }

}
