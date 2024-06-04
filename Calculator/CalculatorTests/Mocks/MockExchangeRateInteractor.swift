//
//  MockExchangeRateInteractor.swift
//  CalculatorTests
//
//  Created by Kenny on 3/06/24.
//

import UIKit
@testable import Calculator

class MockExchangeRateInteractor: ExchangeRateInteractorProtocol {
    var presenter: ExchangeRatePresenterProtocol?
    var getRatesCallCount = 0
    
    func getRates(currency: String) {
        getRatesCallCount += 1
        let rates = ConversionRates(PEN: 3.5, USD: 1.0)
        presenter?.didFetchRates(rates, currency)
    }
}
