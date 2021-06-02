//
//  TraductionTestCase.swift
//  BaluchonTests
//
//  Created by Florian Peyrony on 23/02/2021.
//  Copyright © 2021 Florian Peyrony. All rights reserved.
//

import XCTest
@testable import Baluchon

class TraductionTestCase: XCTestCase {
    func testGetTraductionShouldPostFailCallbackIfError() {
        // Given
        let traductionRateService = TraductionService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataExchangeRate.error))
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        traductionRateService.getTraduction(textToTraduce: "") { (success, traduction) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(traduction)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTraductionShouldPostFailCallbackIfNoData() {
        // Given
        let traductionService = TraductionService(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        traductionService.getTraduction(textToTraduce: "") { (success, traduction) in
            XCTAssertFalse(success)
            XCTAssertNil(traduction)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetTraductionShouldPostFailCallbackIfIncorrectResponse() {
        // Given
        let traductionService = TraductionService(session: URLSessionFake(data: FakeResponseDataTraduction.correctTraductionData, response: FakeResponseDataTraduction.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        traductionService.getTraduction(textToTraduce: "") { (success, traduce) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(traduce)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTraductionShouldPostFailCallbackIfIncorrectData() {
        // Given
        let traductionService = TraductionService(session: URLSessionFake(data: FakeResponseDataTraduction.traductionIncorrectData, response: FakeResponseDataTraduction.responseOK, error: nil))
        // When
        traductionService.getTraduction(textToTraduce: "") { (success, traduce) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(traduce)
        }
    }
    func testGetTraductionShouldPostSuccessCallbackIfCorrectData() {
        // Given
        let traductionService = TraductionService(session: URLSessionFake(data: FakeResponseDataTraduction.correctTraductionData, response: FakeResponseDataTraduction.responseOK, error: nil))
        // When
        traductionService.getTraduction(textToTraduce: "") { (success, traduce) in
            // then
            let text = "Hello"
            XCTAssertTrue(success)
            XCTAssertNotNil(traduce)
            XCTAssertEqual(traduce!.data.translations[0].translatedText, text)
            
        }
    }
}

