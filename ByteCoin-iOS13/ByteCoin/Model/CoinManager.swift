//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case URLError
    case NetworkError
    case DeviceError(String)
    case ClientError(String)
    case OtherError
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey: String = "KEY"
    
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    func getCoinPrice(for currency: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let fullUrl = "\(baseURL)/\(currency)"
        fetchData(url: fullUrl, completion: completion)
    }
    
    func fetchData(url: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let path = URL(string: url) else {
            completion(.failure(NetworkError.URLError))
            return
        }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: path)
        request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
        
        session.dataTask(with: request) { data, res, error in
            if let error {
                completion(.failure(.DeviceError(error.localizedDescription)))
                return
            }
            
            if let data {
                let decoder = JSONDecoder()
                
                do {
                    let response: ExchangeRateDTO = try decoder.decode(ExchangeRateDTO.self, from: data)
                    completion(.success(String(format:"%.2f", response.rate)
                    )
                    )
                    return
                }
                catch {
                    completion(.failure(.ClientError(res.debugDescription)))
                    return
                }
            }
            
            completion(.failure(.OtherError))
            
        }.resume()
    }
}
