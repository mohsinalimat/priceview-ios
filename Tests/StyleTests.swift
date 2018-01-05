//
//  StyleTests.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/13/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import XCTest
@testable import PriceView

final class StyleTests: XCTestCase {
    
    func testFlatInit() {
        let sut = Style(elements:
            .integer(TextStyle(size: 12, weight: .black, color: .blue, kern: 1.1, verticalAlignment: .baseline(5))),
            .decimal(TextStyle(size: 14, weight: .regular, color: .black, verticalAlignment: .top(2))),
            .decimalSeparator(TextStyle(size: 12, weight: .bold, color: .red)),
            .currency(TextStyle(font: UIFont.preferredFont(forTextStyle: .title1), color: .green)),
            .currencySpacing(2),
            .decimalSeparatorSpacing(leading: 1, trailing: 0),
            .fractionDigits(1),
            .verticalAlignment(.bottom),
            .horizontalAlignment(.natural)
        )

        XCTAssertEqual(sut.integer.fontSize, .size(12, .black))
        XCTAssertEqual(sut.integer.color, .blue)
        XCTAssertEqual(sut.integer.kern, 1.1)
        XCTAssertEqual(sut.integer.verticalAlignment, .baseline(5))
        
        XCTAssertEqual(sut.decimal.fontSize, .size(14, .regular))
        XCTAssertEqual(sut.decimal.color, .black)
        XCTAssertEqual(sut.decimal.kern, 0.0)
        XCTAssertEqual(sut.decimal.verticalAlignment, .top(2))
        
        XCTAssertEqual(sut.decimalSeparator.fontSize, .size(12, .bold))
        XCTAssertEqual(sut.decimalSeparator.color, .red)
        XCTAssertEqual(sut.decimalSeparator.kern, 0.0)
        XCTAssertEqual(sut.decimalSeparator.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.currency.fontSize, .font(.preferredFont(forTextStyle: .title1)))
        XCTAssertEqual(sut.currency.color, .green)
        XCTAssertEqual(sut.currency.kern, 0.0)
        XCTAssertEqual(sut.currency.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.decimalSeparatorSpacing.leading, 1)
        XCTAssertEqual(sut.decimalSeparatorSpacing.trailing, 0)
        XCTAssertEqual(sut.currencySpacing, 2)
        XCTAssertEqual(sut.horizontalAlignment, .natural)
        XCTAssertEqual(sut.verticalAlignment, .bottom)
        XCTAssertEqual(sut.fractionDigits, 1)
    }
    
    func testFlatInitDefaultValues() {
        let sut = Style(elements: .integer(TextStyle(size: 12, weight: .bold, color: .red)),
                        .decimal(TextStyle(size: 12, weight: .bold, color: .red)),
                        .decimalSeparator(TextStyle(size: 12, weight: .bold, color: .red)),
                        .currency(TextStyle(size: 12, weight: .bold, color: .red)))
        
        XCTAssertEqual(sut.decimalSeparatorSpacing.leading, 0)
        XCTAssertEqual(sut.decimalSeparatorSpacing.trailing, 0)
        XCTAssertEqual(sut.currencySpacing, 0)
        XCTAssertEqual(sut.horizontalAlignment, .center)
        XCTAssertEqual(sut.verticalAlignment, .middle)
        XCTAssertEqual(sut.fractionDigits, 2)
    }
}
