//
//  ExchangeRateInteractor.swift
//  Calculator
//
//  Created by Kenny on 3/06/24.
//

import UIKit

class ExchangeRateInteractor: ExchangeRateInteractorProtocol {
    var presenter: ExchangeRatePresenterProtocol?
    var exchangeService: ExchangeServiceProtocol?
    
    init(service: ExchangeServiceProtocol) {
        self.exchangeService = service
    }


    func getRates(currency: String) {
        
        exchangeService?.getRates(currency: currency) { [weak self] result in
            switch result {
            case .success(let conversionResult):
                self?.presenter?.didFetchRates(conversionResult.conversionRates, currency)
            case .failure(let error):
                self?.presenter?.didFailToGetRates(error)
            }
        }
        
    }
}
