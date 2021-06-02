//
//  MeteoService.swift
//  Baluchon
//
//  Created by Florian Peyrony on 21/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class MeteoService {

    var task: URLSessionTask?
    private var session: URLSession
   
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    
    func getMeteo(city: String, callback: @escaping (Bool, Meteo?) -> Void) {
        let meteoUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&appid=7c6379add06bf2e4c2a271a9fde9965d")!
        
        var request = URLRequest(url: meteoUrl)
        request.httpMethod = "POST"
        
       
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
            guard let responseJSON = try? JSONDecoder().decode(Meteo.self, from: data) else {
                print("prob JSON")
                callback(false,nil)
                return
            }
            let meteo = Meteo(weather: responseJSON.weather, main: responseJSON.main)
            callback(true,meteo)
        }
        task?.resume()
    }
    
    func getMeteoGeoLoc(latitude: Double, longitude: Double, callback: @escaping (Bool, Meteo?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude )&appid=7c6379add06bf2e4c2a271a9fde9965d"
        let meteoUrl = URL(string: urlString)!
        
        var request = URLRequest(url: meteoUrl)
        request.httpMethod = "POST"
        
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
            guard let responseJSON = try? JSONDecoder().decode(Meteo.self, from: data) else {
                print("prob JSON")
                callback(false,nil)
                return
            }
            let meteo = Meteo(weather: responseJSON.weather, main: responseJSON.main)
            callback(true,meteo)
        }
        task?.resume()
    }
    
    func getImage(iconNumber: String, callback: @escaping (Bool, Data?) -> Void) {
        let imageURL = URL(string: "http://openweathermap.org/img/wn/\(iconNumber)@2x.png")!
     
        task = session.dataTask(with: imageURL) { (data, response, error) in
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
            
            callback(true, data)
        }
        task?.resume()
    }
}
