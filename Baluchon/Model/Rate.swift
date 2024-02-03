//
//  Rate.swift
//  Baluchon
//
//  Created by Florian Peyrony on 25/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

struct Value: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}
