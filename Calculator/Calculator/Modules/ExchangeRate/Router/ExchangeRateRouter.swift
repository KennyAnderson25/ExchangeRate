//
//  ExchangeRateRouter.swift
//  Calculator
//
//  Created by Kenny on 3/06/24.
//

import Foundation
import SwiftUI


class ExchangeRateRouter: ExchangeRateRouterProtocol {
    static func createModule() -> ExchangeRateView {
        let service = ExchangeService()
        let interactor = ExchangeRateInteractor(service: service)
        let presenter = ExchangeRatePresenter()
        let view = ExchangeRateView(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.router = ExchangeRateRouter()
        interactor.presenter = presenter

        return view
    }
}
