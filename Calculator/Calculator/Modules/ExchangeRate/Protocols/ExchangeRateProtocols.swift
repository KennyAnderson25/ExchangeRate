//
//  ExchangeRateProtocols.swift
//  Calculator
//
//  Created by Kenny on 3/06/24.
//

import Foundation
import SwiftUI


protocol ExchangeRateInteractorProtocol: AnyObject {
    func getRates( currency: String)
}

protocol ExchangeRatePresenterProtocol: AnyObject {
    func swapCurrencies()
    func didFetchRates(_ rates: ConversionRates?,_ currency:String)
    func didFailToGetRates(_ error: Error)
}

protocol ExchangeRateRouterProtocol {
    associatedtype ExchangeRateView: View
    static func createModule() -> ExchangeRateView
}
