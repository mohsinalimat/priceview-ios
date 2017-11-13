//
//  SymbolPositionTests.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/13/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import XCTest
@testable import PriceView

final class SymbolPositionTests: XCTestCase {
    
    func testFrenchCurrencyIsAfter() {
        let sut = SymbolPosition(with: Locale(identifier: "fr_FR"))
        XCTAssertEqual(sut, .afterCurrency)
    }
    
    func testUSACurrencyIsBefore() {
        let sut = SymbolPosition(with: Locale(identifier: "en_US"))
        XCTAssertEqual(sut, .beforeCurrency)
    }
    
    func testAustraliaCurrencyIsBefore() {
        let sut = SymbolPosition(with: Locale(identifier: "en_AU"))
        XCTAssertEqual(sut, .beforeCurrency)
    }

    func testEnglandCurrencyIsBefore() {
        let sut = SymbolPosition(with: Locale(identifier: "en_GB"))
        XCTAssertEqual(sut, .beforeCurrency)
    }

    func testCanadaCurrencyIsBefore() {
        let sut = SymbolPosition(with: Locale(identifier: "en_CA"))
        XCTAssertEqual(sut, .beforeCurrency)
    }

    func testSpainCurrencyIsAfter() {
        let sut = SymbolPosition(with: Locale(identifier: "es_ES"))
        XCTAssertEqual(sut, .afterCurrency)
    }
    
    func testKoreaCurrencyIsAfter() {
        let sut = SymbolPosition(with: Locale(identifier: "ko"))
        XCTAssertEqual(sut, .beforeCurrency)
    }

    func testSingapourCurrencyIsAfter() {
        let sut = SymbolPosition(with: Locale(identifier: "en_SG"))
        XCTAssertEqual(sut, .beforeCurrency)
    }

    func testJapanCurrencyIsAfter() {
        let sut = SymbolPosition(with: Locale(identifier: "ja_JA"))
        XCTAssertEqual(sut, .beforeCurrency)
    }
}

