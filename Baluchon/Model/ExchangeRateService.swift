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
    
    static func getRate() {
        var request = URLRequest(url: rateUrl)
        request.httpMethod = "POST"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode(value.self, from: data) {
                        print("\(responseJSON.rates)")
                        // for rate in responseJSON.rates {
                        //    print(rate)
                        // }
                    } else {
                        print("prob JSON")
                    }
                    print(data)
                } else {
                    print("statut pas bon")
                }
            } else {
                print("prob data ou erreur")
            }
        }
        task.resume()
    }
}
