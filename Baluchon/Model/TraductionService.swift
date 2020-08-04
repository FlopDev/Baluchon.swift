//
//  TraductionService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

class TraductionRateService {
    private static let meteoUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    var textToTraduce: String = "Bonjour"
    
    static func getTraduction(textToTraduce:String) {
        var request = URLRequest(url: meteoUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTraduce)&source=fr&target=en&format=text&key=AIzaSyCwmeFm1w5Nnar60uVwuvJfX5h6qldhJrE"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: Int].self, from: data), let rate = responseJSON["data"] {
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
