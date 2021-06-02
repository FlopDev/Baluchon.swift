//
//  ExchangeRateService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

class ExchangeRateService {
    
    private static let rateUrl = URL(string: "http://data.fixer.io/api/latest?access_key=cfd185ed15f6519ed2c719bc1a1762c1&=")!
    var task: URLSessionTask?
    var session = URLSession(configuration: .default)
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    
    
       func getRate(callback: @escaping(Bool,Value?) -> Void) {
        var request = URLRequest(url: ExchangeRateService.rateUrl)
        request.httpMethod = "POST"
        
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("prob data ou erreur")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("statut pas bon")
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Value.self, from: data) else {
                print("prob JSON")
                return
            }
            let value = Value(success: true, timestamp: 1, base: "0", date: "0", rates: responseJSON.rates)
            callback(true,value)
            
        }
        task?.resume()
    }
}
