//
//  FakeResponseDataTraduction.swift
//  BaluchonTests
//
//  Created by Florian Peyrony on 23/02/2021.
//  Copyright © 2021 Florian Peyrony. All rights reserved.
//

import Foundation

class FakeResponseDataTraduction {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class TraductionError: Error {}
    static let error = TraductionError()
    
    static var correctTraductionData: Data {
        let bundle = Bundle(for: FakeResponseDataTraduction.self)
        let url = bundle.url(forResource: "Traduction", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let traductionIncorrectData = "Error".data(using: .utf8)!
}
