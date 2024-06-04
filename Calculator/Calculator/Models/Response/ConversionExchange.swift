//
//  ConversionExchange.swift
//  Calculator
//
//  Created by Kenny on 3/06/24.
//

import UIKit

struct ConversionExchange: Codable {
    let result: String
    let documentation, termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUTC: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUTC, baseCode: String
    let conversionRates: ConversionRates?
    
    enum CodingKeys: String, CodingKey {
            case result, documentation
            case termsOfUse = "terms_of_use"
            case timeLastUpdateUnix = "time_last_update_unix"
            case timeLastUpdateUTC = "time_last_update_utc"
            case timeNextUpdateUnix = "time_next_update_unix"
            case timeNextUpdateUTC = "time_next_update_utc"
            case baseCode = "base_code"
            case conversionRates = "conversion_rates"
        }
}

struct ConversionRates:Codable {
    
    let PEN: Double?
    let USD:Double?
}
