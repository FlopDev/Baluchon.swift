//
//  Traduction.swift
//  Baluchon
//
//  Created by Florian Peyrony on 25/07/2020.
//  Copyright © 2020 Florian Peyrony. All rights reserved.
//

import Foundation

struct Traduce: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String
}
