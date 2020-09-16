//
//  MeteoService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

class MeteoService {
    
    static func getMeteo(city: String, callback: @escaping (Bool, Meteo?) -> Void) {
        let meteoUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&appid=7c6379add06bf2e4c2a271a9fde9965d")!
        
        var request = URLRequest(url: meteoUrl)
        request.httpMethod = "POST"
        
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
            guard let responseJSON = try? JSONDecoder().decode(Meteo.self, from: data) else {
                print("prob JSON")
                callback(false,nil)
                return
            }
            let meteo = Meteo(weather: responseJSON.weather, main: responseJSON.main)
            callback(true,meteo)
        }
        task.resume()
    }
    
    func staticFuncGetMeteoByID(long: Double, lat: Double) {
        
    }
}
