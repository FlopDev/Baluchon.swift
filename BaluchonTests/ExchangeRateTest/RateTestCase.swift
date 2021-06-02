//
//  RateTestCase.swift
//  BaluchonTests
//
//  Created by Florian Peyrony on 23/02/2021.
//  Copyright © 2021 Florian Peyrony. All rights reserved.
//

@testable import Baluchon
import XCTest


class RateTestCase: XCTestCase {

    func testGetRateShouldPostFailCallbackIfError() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataExchangeRate.error))
        // When
        exchangeRateService.getRate { (success, rate) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
        }
    }
    
    func testGetRateShouldPostFailCallbackIfNoData() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        exchangeRateService.getRate { (success, rate) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
        }
    }
    
    func testGetRateShouldPostFailCallbackIfIncorrectResponse() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: FakeResponseDataExchangeRate.correctExchangeRateData, response: FakeResponseDataExchangeRate.responseKO, error: nil))
        // When
        exchangeRateService.getRate { (success, rate) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
        }
    }
    func testGetRateShouldPostFailCallbackIfInCorrectData() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: FakeResponseDataExchangeRate.exchangeRateIncorrectData, response: FakeResponseDataExchangeRate.responseOK, error: nil))
        // When
        exchangeRateService.getRate { (success, rate) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
        }
    }
    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(data: FakeResponseDataExchangeRate.correctExchangeRateData, response: FakeResponseDataExchangeRate.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        exchangeRateService.getRate { (success, exchangeRate) in
            // then
            let rate = [
                "AED": 4.462256,
                "AFN": 93.783934,
                "ALL": 123.4947,
                "AMD": 638.744113,
                "ANG": 2.180787,
                "AOA": 787.253485,
                "ARS": 108.706514,
                "AUD": 1.534416,
                "AWG": 2.186815,
                "AZN": 2.069229,
                "BAM": 1.955262,
                "BBD": 2.453065,
                "BDT": 103.020193,
                "BGN": 1.955587,
                "BHD": 0.457655,
                "BIF": 2381.198253,
                "BMD": 1.214897,
                "BND": 1.604375,
                "BOB": 8.389072,
                "BRL": 6.607711,
                "BSD": 1.214937,
                "BTC": 2.5629013e-5,
                "BTN": 88.037578,
                "BWP": 13.191699,
                "BYN": 3.158283,
                "BYR": 23811.98253,
                "BZD": 2.448947,
                "CAD": 1.528249,
                "CDF": 2416.430628,
                "CHF": 1.099721,
                "CLF": 0.031027,
                "CLP": 856.144448,
                "CNY": 7.856314,
                "COP": 4366.94751,
                "CRC": 743.256785,
                "CUC": 1.214897,
                "CUP": 32.194772,
                "CVE": 110.738104,
                "CZK": 25.859449,
                "DJF": 215.911218,
                "DKK": 7.436868,
                "DOP": 70.501021,
                "DZD": 161.369534,
                "EGP": 19.047283,
                "ERN": 18.223744,
                "ETB": 48.478679,
                "EUR": 1,
                "FJD": 2.466327,
                "FKP": 0.860887,
                "GBP": 0.860846,
                "GEL": 4.033389,
                "GGP": 0.860887,
                "GHS": 6.985578,
                "GIP": 0.860887,
                "GMD": 62.300392,
                "GNF": 12252.236822,
                "GTQ": 9.358011,
                "GYD": 254.105266,
                "HKD": 9.420372,
                "HNL": 29.595065,
                "HRK": 7.579133,
                "HTG": 92.361566,
                "HUF": 358.554392,
                "IDR": 17104.839542,
                "ILS": 3.971559,
                "IMP": 0.860887,
                "INR": 87.940992,
                "IQD": 1776.786962,
                "IRR": 51153.240852,
                "ISK": 154.996791,
                "JEP": 0.860887,
                "JMD": 183.959417,
                "JOD": 0.86134,
                "JPY": 127.910427,
                "KES": 133.289826,
                "KGS": 102.836422,
                "KHR": 4938.556374,
                "KMF": 492.216129,
                "KPW": 1093.428312,
                "KRW": 1349.02779,
                "KWD": 0.367567,
                "KYD": 1.012423,
                "KZT": 504.130352,
                "LAK": 11365.362268,
                "LBP": 1852.107638,
                "LKR": 235.085486,
                "LRD": 210.632787,
                "LSL": 17.689142,
                "LTL": 3.587276,
                "LVL": 0.734879,
                "LYD": 5.4124,
                "MAD": 10.821392,
                "MDL": 21.299512,
                "MGA": 4577.06963,
                "MKD": 61.593051,
                "MMK": 1713.026257,
                "MNT": 3462.821655,
                "MOP": 9.702423,
                "MRO": 433.718044,
                "MUR": 48.225838,
                "MVR": 18.721953,
                "MWK": 944.57709,
                "MXN": 24.925485,
                "MYR": 4.912437,
                "MZN": 91.166091,
                "NAD": 17.689019,
                "NGN": 462.876005,
                "NIO": 42.582307,
                "NOK": 10.28685,
                "NPR": 140.858167,
                "NZD": 1.653724,
                "OMR": 0.467707,
                "PAB": 1.214937,
                "PEN": 4.437407,
                "PGK": 4.294651,
                "PHP": 59.059179,
                "PKR": 193.168717,
                "PLN": 4.505992,
                "PYG": 8043.701186,
                "QAR": 4.423396,
                "RON": 4.875625,
                "RSD": 117.518122,
                "RUB": 89.837628,
                "RWF": 1196.673612,
                "SAR": 4.556677,
                "SBD": 9.696524,
                "SCR": 25.761118,
                "SDG": 456.862253,
                "SEK": 10.062069,
                "SGD": 1.603288,
                "SHP": 0.860887,
                "SLL": 12410.173297,
                "SOS": 711.929635,
                "SRD": 17.195654,
                "STD": 24640.705106,
                "SVC": 10.630862,
                "SYP": 622.969717,
                "SZL": 17.689179,
                "THB": 36.48703,
                "TJS": 13.844367,
                "TMT": 4.264289,
                "TND": 3.281488,
                "TOP": 2.780176,
                "TRY": 8.640014,
                "TTD": 8.251556,
                "TWD": 33.842051,
                "TZS": 2817.476272,
                "UAH": 33.932842,
                "UGX": 4458.911054,
                "USD": 1.214897,
                "UYU": 52.077585,
                "UZS": 12819.593737,
                "VEF": 12.133786,
                "VND": 27979.079472,
                "VUV": 129.987304,
                "WST": 3.046599,
                "XAF": 655.70175,
                "XAG": 0.043878,
                "XAU": 0.000673,
                "XCD": 3.28332,
                "XDR": 0.842272,
                "XOF": 654.829823,
                "XPF": 119.8192,
                "YER": 304.14971,
                "ZAR": 17.674164,
                "ZMK": 10935.53377,
                "ZMW": 26.415869,
                "ZWL": 391.197258
            ]
            XCTAssertTrue(success)
            XCTAssertNotNil(exchangeRate)
            XCTAssertEqual(rate, exchangeRate?.rates)
            expectation.fulfill()
        }
         
        wait(for: [expectation], timeout: 0.01)
    }
}
