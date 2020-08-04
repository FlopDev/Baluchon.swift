//
//  Rate.swift
//  Baluchon
//
//  Created by Florian Peyrony on 25/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

struct Rates: Decodable {
    var rates: [String : Double]
}

struct USDRate: Decodable {
    var USD: Rates
}
