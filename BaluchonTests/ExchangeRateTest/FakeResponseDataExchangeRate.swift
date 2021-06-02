//
//  FakeResponseDataExchangeRate.swift
//  BaluchonTests
//
//  Created by Florian Peyrony on 08/03/2021.
//  Copyright © 2021 Florian Peyrony. All rights reserved.
//

import Foundation

class FakeResponseDataExchangeRate {
       static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
    class QuoteError: Error {}
        static let error = QuoteError()
        
        static var correctExchangeRateData: Data {
            let bundle = Bundle(for: FakeResponseDataExchangeRate.self)
            let url = bundle.url(forResource: "Rate", withExtension: "json")
            let data = try! Data(contentsOf: url!)
            return data
        }
        
        static let exchangeRateIncorrectData = "Error".data(using: .utf8)!
}
