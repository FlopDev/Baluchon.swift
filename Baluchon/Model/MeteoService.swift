//
//  MeteoService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

class MeteoService {
    private static let meteoUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    
    static func getRate() {
        var request = URLRequest(url: meteoUrl)
        request.httpMethod = "POST"
        let body = "q=Niort&appid=7c6379add06bf2e4c2a271a9fde9965d"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: Int].self, from: data), let rate = responseJSON["main"] {
                        print(rate)
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
