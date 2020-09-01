//
//  TraductionService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

class TraductionRateService {
    
    private static let traductionUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    var textToTraduce: String = ""
    
    static func getTraduction(textToTraduce:String) {
        
        var request = URLRequest(url: traductionUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTraduce)&source=fr&target=en&format=text&key=AIzaSyAsKEcSHiBpO0LsVUIqfZU1A709BnxsW8o"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("prob data ou erreur")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("statut pas bon")
                return
            }
            guard let responseJSON = try? JSONDecoder().decode([String: Int].self, from: data), let traduction = responseJSON["data"] else {
                print("prob JSON")
                return
            }
            print(traduction)
            print(data)
        }
        task.resume()
    }
}
