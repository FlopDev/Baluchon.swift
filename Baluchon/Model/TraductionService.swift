//
//  TraductionService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

class TraductionService {

    
    private static let traductionUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    private var task: URLSessionTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    

    var textToTraduce: String = ""
    
    func getTraduction(textToTraduce:String, callback: @escaping (Bool,Traduce?) -> Void) {
        
        var request = URLRequest(url: TraductionService.traductionUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTraduce)&source=fr&target=en&format=text&key=AIzaSyAAWgqjawEpXQslR12yvakIJ1teczTtP8g"
        request.httpBody = body.data(using: .utf8)
        
       
         task = session.dataTask(with: request) { (data, response, error) in
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
        task?.resume()
    }
}
