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
    
    static func getTraduction(textToTraduce:String, callback: @escaping (Bool,Traduce?) -> Void) {
        
        var request = URLRequest(url: traductionUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTraduce)&source=fr&target=en&format=text&key=AIzaSyAsKEcSHiBpO0LsVUIqfZU1A709BnxsW8o"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("prob data ou erreur")
                callback(false,nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("statut pas bon")
                callback(false,nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Traduce.self, from: data) else {
                print("prob JSON")
                callback(false,nil)
                return
            }
            let traduce = Traduce(data: responseJSON.data)
            callback(true,traduce)
        }
        task.resume()
    }
}
