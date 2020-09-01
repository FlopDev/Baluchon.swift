//
//  Rate.swift
//  Baluchon
//
//  Created by Florian Peyrony on 25/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

struct value: Decodable {
    let success: String
    let timestamp: Int
    let base: String
    let date: String
    let rates: Rates
}

struct Rates: Decodable {
    var allRates: [String : Double]
}

