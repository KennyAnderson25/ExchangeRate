//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Kenny on 1/06/24.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ExchangeRateRouter.createModule()
        }
    }
}
