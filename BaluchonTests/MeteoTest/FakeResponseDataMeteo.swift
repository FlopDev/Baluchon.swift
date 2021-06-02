//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Florian Peyrony on 23/02/2021.
//  Copyright © 2021 Florian Peyrony. All rights reserved.
//

import Foundation
import UIKit

class FakeResponseDataMeteo {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class QuoteError: Error {}
    static let error = QuoteError()
    
    static var correctMeteoCityData: Data {
        let bundle = Bundle(for: FakeResponseDataMeteo.self)
        let url = bundle.url(forResource: "MeteoCity", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static var correctMeteoLocData: Data {
        let bundle = Bundle(for: FakeResponseDataMeteo.self)
        let url = bundle.url(forResource: "MeteoLoc", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectMeteoData = "Error".data(using: .utf8)!
    static let incorrectImageData = "image".data(using: .utf8)!
    static let correctImageData = #imageLiteral(resourceName: "clear").pngData()
}
