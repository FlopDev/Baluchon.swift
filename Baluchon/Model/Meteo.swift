//
//  Meteo.swift
//  Baluchon
//
//  Created by Florian Peyrony on 25/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

struct meteo: Decodable{
    let main : weatherCondition
    let temp : tempKalvin
}


struct weatherCondition: Decodable {
    let id: Int
    let main: String
    // On prend celui ci
    let description: String
    // Ou celui la
    let icon: String
    
}
struct tempKalvin: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}
