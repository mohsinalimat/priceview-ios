//
//  FormatterTests.swift
//  PriceViewTests
//
//  Created by Thomas Sivilay on 11/9/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import XCTest
@testable import PriceView

final class FormatterTests: XCTestCase {
    
    func testZeroWithNoDecimal() {
        test(price: 0, expectedIntegerPart: "0", expectedDecimalPart: "00")
    }
    
    func testZeroWithDecimal() {
        test(price: 0.0, expectedIntegerPart: "0", expectedDecimalPart: "00")
    }
    
    func testZeroWithDecimalsAndLeadingZeros() {
        test(price: 00.00, expectedIntegerPart: "0", expectedDecimalPart: "00")
    }
    
    func testLeadingDecimalWithZero() {
        test(price: 10.05, expectedIntegerPart: "10", expectedDecimalPart: "05")
    }
    
    func testLeadingDecimalWithZeroRoundUp() {
        test(price: 10.007, expectedIntegerPart: "10", expectedDecimalPart: "01")
    }
    
    func testLeadingDecimalWithZeroFive() {
        test(price: 10.005, expectedIntegerPart: "10", expectedDecimalPart: "00")
    }
    
    func testLeadingDecimalWithTooManyZeros() {
        test(price: 1.000005, expectedIntegerPart: "1", expectedDecimalPart: "00")
    }
    
    func testDecimals() {
        test(price: 0.34, expectedIntegerPart: "0", expectedDecimalPart: "34")
    }
    
    func testLongDecimals() {
        test(price: 0.344413321312, expectedIntegerPart: "0", expectedDecimalPart: "34")
    }
    
    func testIntegerWithNoDecimal() {
        test(price: 12, expectedIntegerPart: "12", expectedDecimalPart: "00")
    }
    
    func testIntegerWithDecimals() {
        test(price: 12.0, expectedIntegerPart: "12", expectedDecimalPart: "00")
    }
    
    func testIntegerWithLongDecimals() {
        test(price: 12.0232148913, expectedIntegerPart: "12", expectedDecimalPart: "02")
    }
    
    func testLongIntegerWithLongDecimals() {
        test(price: 13213145162.0232148913, expectedIntegerPart: "13,213,145,162", expectedDecimalPart: "02")
    }
    
    func testNegativeLongIntegerWithLongDecimals() {
        test(price: -13213145162.0232148913, expectedIntegerPart: "-13,213,145,162", expectedDecimalPart: "02")
    }
    
    func testNegativeZero() {
        test(price: -0, expectedIntegerPart: "0", expectedDecimalPart: "00")
    }
    
    func testNegativeZeroWithDecimals() {
        test(price: -0.213151, expectedIntegerPart: "-0", expectedDecimalPart: "21")
    }
    
    func testThousandsWithFrenchLocale() {
        test(price: 123456789.011, expectedIntegerPart: "123 456 789", expectedDecimalPart: "01", localeIdentifier: "fr_FR")
    }

    func testRoundUpWithManyDecimals() {
        test(price: 01.0000009, expectedIntegerPart: "1", expectedDecimalPart: "00")
    }
    
    func testWithManyDecimalsWithCustomFractionNumber() {
        test(price: 01.0000009, expectedIntegerPart: "1", expectedDecimalPart: "0000", fractionNumber: 4)
    }
    
    func testRoundUpWithManyDecimalsWithCustomFractionNumber() {
        test(price: 01.00000090123, expectedIntegerPart: "1", expectedDecimalPart: "000001", fractionNumber: 6)
    }

    func testRoundUp99centsWithoutDecimal() {
        test(price: 16.99, expectedIntegerPart: "17", expectedDecimalPart: "", fractionNumber: 0)
    }
    
    func testRoundUp99centsWithOneDecimal() {
        test(price: 16.99, expectedIntegerPart: "17", expectedDecimalPart: "0", fractionNumber: 1)
    }

    func testRoundUp99centsWithTwoDecimals() {
        test(price: 16.99, expectedIntegerPart: "16", expectedDecimalPart: "99", fractionNumber: 2)
    }
    
    func testRoundUp99centsWithThreeDecimals() {
        test(price: 16.999, expectedIntegerPart: "16", expectedDecimalPart: "999", fractionNumber: 3)
    }
    
    func testNoRoundUp49centsWithoutDecimal() {
        test(price: 16.49, expectedIntegerPart: "16", expectedDecimalPart: "", fractionNumber: 0)
    }
    
    func testNoRoundUp49centsWithOneDecimal() {
        test(price: 16.49, expectedIntegerPart: "16", expectedDecimalPart: "5", fractionNumber: 1)
    }
    
    func test(price: Double,
              expectedIntegerPart: String,
              expectedDecimalPart: String,
              localeIdentifier: String = "en_US",
              fractionNumber: Int? = nil,
              file: StaticString = #file,
              line: UInt = #line) {
        let locale = Locale(identifier: localeIdentifier)
        let style = makeStyle(with: locale, fractionNumber: fractionNumber)
        let formatter = Formatter(with: style)
        let formattedInt = formatter.formattedInteger(price: price)
        let formattedDecimal = formatter.formattedDecimal(price: price)

        XCTAssertEqual(formattedInt, expectedIntegerPart, "integer part", file: file, line: line)
        XCTAssertEqual(formattedDecimal, expectedDecimalPart, "decimal part", file: file, line: line)
    }
    
    private func makeStyle(with locale: Locale, fractionNumber: Int? = nil) -> Style {
        let aTextStyle = TextStyle(size: 12, color: .black)
        if let fractionNumber = fractionNumber {
            return Style(defaultTextStyle: aTextStyle, numberFraction: fractionNumber, locale: locale)
        } else {
            return Style(defaultTextStyle: aTextStyle, locale: locale)
        }
    }
}
