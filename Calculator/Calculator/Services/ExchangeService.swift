//
//  ExcangeService.swift
//  Calculator
//
//  Created by Kenny on 3/06/24.
//

import UIKit

protocol ExchangeServiceProtocol {
    func getExchangeRates(completion: @escaping (Result<ExchangeRates, Error>) -> Void)
    func getRates(currency: String,  completion: @escaping (Result<ConversionExchange, Error>) -> Void)
}

class ExchangeService: ExchangeServiceProtocol {
    private let baseURL = ServiceConstants.echangeUri
    
    func getExchangeRates(completion: @escaping (Result<ExchangeRates, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(ExchangeRates.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getRates( currency: String, completion: @escaping (Result<ConversionExchange, Error>) -> Void) {
        let conversionURL = "\(baseURL)/\(currency)"
        print("API->", conversionURL)
        guard let url = URL(string: conversionURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(ConversionExchange.self, from: data)
                print("El servicio respondió",decodedData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
