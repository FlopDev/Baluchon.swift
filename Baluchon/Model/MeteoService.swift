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
    
    static func getMeteo(city: String) {
        var request = URLRequest(url: meteoUrl)
        request.httpMethod = "POST"
        let body = "q\(city)&appid=7c6379add06bf2e4c2a271a9fde9965d"
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
            guard let responseJSON = try? JSONDecoder().decode(meteo.self, from: data) else {
                print("prob JSON")
                return
            }
            print("\(response.statusCode)")
            let descriptionOfWeather = responseJSON.main
            let temperature = responseJSON.temp
            print("\(descriptionOfWeather) + \(temperature)")
        }
        task.resume()
    }
    
    func getTempInCelcius(temperatureInKelvin: Double) -> Double {
        let temperatureInCelcius = temperatureInKelvin - 273.15
        return temperatureInCelcius
    }
}
