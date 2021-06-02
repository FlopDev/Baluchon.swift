//
//  MeteoTestCase.swift
//  BaluchonTests
//
//  Created by Florian Peyrony on 23/02/2021.
//  Copyright © 2021 Florian Peyrony. All rights reserved.
//
import XCTest
@testable import Baluchon


class MeteoTestCase: XCTestCase {
    func testGetMeteoShouldPostFailCallbackIfError() {
        // Given
        let meteo = MeteoService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataMeteo.error))
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        meteo.getMeteo(city: "Londres") { (success, rate) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMeteoShouldPostFailCallbackIfNoData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        meteoService.getMeteo(city: "Londres") { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetMeteoShouldPostFailCallbackIfIncorrectResponse() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctMeteoCityData, response: FakeResponseDataMeteo.responseKO, error: nil))
        // When
        meteoService.getMeteo(city: "Londres") { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
        }
    }
    
    func testGetMeteoShouldPostFailCallbackIfIncorrectData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.incorrectMeteoData, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getMeteo(city: "Londres") { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
        }
        
    }
    
    func testGetMeteoShouldPostFailedNotificationIfNoPictureData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: nil, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getImage(iconNumber: "") { (success, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(data)
        }
        
    }
    
    func testGetMeteoShouldPostSuccessCallbackIfCorrectData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctMeteoCityData, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getMeteo(city: "Londres") { (success, meteo) in
            // then
            let meteoTemp = 289.99
            XCTAssertTrue(success)
            XCTAssertNotNil(meteo)
            XCTAssertEqual(meteoTemp, meteo!.main.temp)
        }
    }
    
    // getMeteoByLoc
    
    func testGetMeteoByLocShouldPostFailCallbackIfError() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataMeteo.error))
        // When
        meteoService.getMeteoGeoLoc(latitude: 0.0, longitude: 0.0) { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
        }
    }
    
    func testGetMeteoByLocShouldPostFailCallbackIfNoData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        meteoService.getMeteoGeoLoc(latitude: 0.0, longitude: 0.0) { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
        }
        
    }
    
    
    func testGetMeteoByLocShouldPostFailCallbackIfIncorrectResponse() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctMeteoCityData, response: FakeResponseDataMeteo.responseKO, error: nil))
        // When
        meteoService.getMeteoGeoLoc(latitude: 0.0, longitude: 0.0) { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
        }
    }
    
    func testGetMeteoByLocShouldPostFailCallbackIfIncorrectData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.incorrectMeteoData, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getMeteoGeoLoc(latitude: 0.0, longitude: 0.0) { (success, meteo) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(meteo)
        }
    }
    
    func testGetMeteoByLocShouldPostFailedNotificationIfNoPictureData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: nil, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getImage(iconNumber: "") { (success, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(data)
        }
        
    }
    
    func testGetMeteoByLocShouldPostSuccessCallbackIfCorrectData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctMeteoCityData, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getMeteoGeoLoc(latitude: 0.0, longitude: 0.0) { (success, meteo) in
            // then
            let meteoTemp = 289.99
            XCTAssertTrue(success)
            XCTAssertNotNil(meteo)
            XCTAssertEqual(meteoTemp, meteo!.main.temp)
        }
        
    }
    
    
    func testGetImageMeteoShouldPostSuccessCallbackIfCorrectData() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctImageData, response: FakeResponseDataMeteo.responseOK, error: nil))
        // When
        meteoService.getImage(iconNumber: "") { (success, meteo) in
            // then
            XCTAssertTrue(success)
            XCTAssertNotNil(meteo)
        }
    }
    
    func testGetImageShouldPostFailedNotificationIfError() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctMeteoCityData, response: FakeResponseDataMeteo.responseOK, error: FakeResponseDataMeteo.error))
        
        // When
        
        meteoService.getImage(iconNumber: "") { (success, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(data)
        }
    }
    
    func testImageShouldPostFailedNotificationIfIncorrectResponse() {
        // Given
        let meteoService = MeteoService(session: URLSessionFake(data: FakeResponseDataMeteo.correctMeteoCityData, response: FakeResponseDataMeteo.responseKO, error: nil))
        
        // When
        meteoService.getImage(iconNumber: "") { (success, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(data)
        }
    }
}
