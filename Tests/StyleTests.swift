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
        let sut = Style(integerTextStyle: TextStyle(size: 12, weight: .black, color: .blue, kern: 1.1, verticalAlignment: .baseline(5)),
                        decimalTextStyle: TextStyle(size: 14, weight: .regular, color: .black, verticalAlignment: .top(2)),
                        decimalSeparatorTextStyle: TextStyle(size: 12, weight: .bold, color: .red),
                        currencyTextStyle: TextStyle(font: UIFont.preferredFont(forTextStyle: .title1), color: .green),
                        decimalSeparatorSpacing: (leading: 1, trailing: 0),
                        currencySpacing: 2,
                        fractionDigits: 1,
                        verticalAlignment: Layout.VerticalAlignment.bottom,
                        textAlignment: .natural)

        XCTAssertEqual(sut.textStyles.integer.fontSize, .size(12, .black))
        XCTAssertEqual(sut.textStyles.integer.color, .blue)
        XCTAssertEqual(sut.textStyles.integer.kern, 1.1)
        XCTAssertEqual(sut.textStyles.integer.verticalAlignment, .baseline(5))
        
        XCTAssertEqual(sut.textStyles.decimal.fontSize, .size(14, .regular))
        XCTAssertEqual(sut.textStyles.decimal.color, .black)
        XCTAssertEqual(sut.textStyles.decimal.kern, 0.0)
        XCTAssertEqual(sut.textStyles.decimal.verticalAlignment, .top(2))
        
        XCTAssertEqual(sut.textStyles.decimalSeparator.fontSize, .size(12, .bold))
        XCTAssertEqual(sut.textStyles.decimalSeparator.color, .red)
        XCTAssertEqual(sut.textStyles.decimalSeparator.kern, 0.0)
        XCTAssertEqual(sut.textStyles.decimalSeparator.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.textStyles.currency.fontSize, .font(.preferredFont(forTextStyle: .title1)))
        XCTAssertEqual(sut.textStyles.currency.color, .green)
        XCTAssertEqual(sut.textStyles.currency.kern, 0.0)
        XCTAssertEqual(sut.textStyles.currency.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.leading, 1)
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.trailing, 0)
        XCTAssertEqual(sut.layout.currencySpacing, 2)
        XCTAssertEqual(sut.layout.horizontalAlignment, .natural)
        XCTAssertEqual(sut.layout.verticalAlignment, .bottom)
        XCTAssertEqual(sut.options.fractionDigits, 1)
    }
    
    func testFlatInitDefaultValues() {
        let sut = Style(integerTextStyle: TextStyle(size: 12, weight: .bold, color: .red),
                        decimalTextStyle: TextStyle(size: 12, weight: .bold, color: .red),
                        decimalSeparatorTextStyle: TextStyle(size: 12, weight: .bold, color: .red),
                        currencyTextStyle: TextStyle(size: 12, weight: .bold, color: .red))
        
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.leading, 0)
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.trailing, 0)
        XCTAssertEqual(sut.layout.currencySpacing, 0)
        XCTAssertEqual(sut.layout.horizontalAlignment, .center)
        XCTAssertEqual(sut.layout.verticalAlignment, .middle)
        XCTAssertEqual(sut.options.fractionDigits, 2)
    }
    
    func testVariadicInitUseCustomDefaultWhenMissing() {
        let sut = Style(defaultTextStyle: TextStyle(size: 12, weight: .black, color: .blue, kern: 1.1, verticalAlignment: .baseline(5)),
                        layout: Layout(verticalAlignment: .top, horizontalAlignment: .left, currencySpacing: 2, decimalSeparatorSpacing: (leading: -1, trailing: 3)),
                        options: Options(fractionDigits: 3), textStyles: TextStyleType.currency(TextStyle(size: 18, color: .red)))
        
        XCTAssertEqual(sut.textStyles.integer.fontSize, .size(12, .black))
        XCTAssertEqual(sut.textStyles.integer.color, .blue)
        XCTAssertEqual(sut.textStyles.integer.kern, 1.1)
        XCTAssertEqual(sut.textStyles.integer.verticalAlignment, .baseline(5))
        
        XCTAssertEqual(sut.textStyles.decimal.fontSize, .size(12, .black))
        XCTAssertEqual(sut.textStyles.decimal.color, .blue)
        XCTAssertEqual(sut.textStyles.decimal.kern, 1.1)
        XCTAssertEqual(sut.textStyles.decimal.verticalAlignment, .baseline(5))
        
        XCTAssertEqual(sut.textStyles.decimalSeparator.fontSize, .size(12, .black))
        XCTAssertEqual(sut.textStyles.decimalSeparator.color, .blue)
        XCTAssertEqual(sut.textStyles.decimalSeparator.kern, 1.1)
        XCTAssertEqual(sut.textStyles.decimalSeparator.verticalAlignment, .baseline(5))
        
        XCTAssertEqual(sut.textStyles.currency.fontSize, .size(18, .semibold))
        XCTAssertEqual(sut.textStyles.currency.color, .red)
        XCTAssertEqual(sut.textStyles.currency.kern, 0.0)
        XCTAssertEqual(sut.textStyles.currency.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.leading, -1)
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.trailing, 3)
        XCTAssertEqual(sut.layout.currencySpacing, 2)
        XCTAssertEqual(sut.layout.horizontalAlignment, .left)
        XCTAssertEqual(sut.layout.verticalAlignment, .top)
        XCTAssertEqual(sut.options.fractionDigits, 3)
    }
    
    func testVariadicInitDefaultStyle() {
        let sut = Style(textStyles: .integer(TextStyle(size: 17, color: .cyan)))
        
        XCTAssertEqual(sut.textStyles.integer.fontSize, .size(17, .semibold))
        XCTAssertEqual(sut.textStyles.integer.color, .cyan)
        XCTAssertEqual(sut.textStyles.integer.kern, 0.0)
        XCTAssertEqual(sut.textStyles.integer.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.textStyles.decimal.fontSize, .size(12, .semibold))
        XCTAssertEqual(sut.textStyles.decimal.color, .black)
        XCTAssertEqual(sut.textStyles.decimal.kern, 0.0)
        XCTAssertEqual(sut.textStyles.decimal.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.textStyles.decimalSeparator.fontSize, .size(12, .semibold))
        XCTAssertEqual(sut.textStyles.decimalSeparator.color, .black)
        XCTAssertEqual(sut.textStyles.decimalSeparator.kern, 0.0)
        XCTAssertEqual(sut.textStyles.decimalSeparator.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.textStyles.currency.fontSize, .size(12, .semibold))
        XCTAssertEqual(sut.textStyles.currency.color, .black)
        XCTAssertEqual(sut.textStyles.currency.kern, 0.0)
        XCTAssertEqual(sut.textStyles.currency.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.leading, 0)
        XCTAssertEqual(sut.layout.decimalSeparatorSpacing.trailing, 0)
        XCTAssertEqual(sut.layout.currencySpacing, 0)
        XCTAssertEqual(sut.layout.horizontalAlignment, .center)
        XCTAssertEqual(sut.layout.verticalAlignment, .middle)
        XCTAssertEqual(sut.options.fractionDigits, 2)
    }
    
    func testVariadicInitAllSetStyle() {
        let sut = Style(textStyles: .currency(TextStyle(size: 12, color: .red)),
                        .decimal(TextStyle(size: 13, weight: .medium, color: .black, kern: 1.1, verticalAlignment: .bottom(2))),
                        .decimalSeparator(TextStyle(font: .preferredFont(forTextStyle: .caption2), color: .brown, kern: 1.3)),
                        .integer(TextStyle(size: 10, color: .green)))
        
        XCTAssertEqual(sut.textStyles.integer.fontSize, .size(10, .semibold))
        XCTAssertEqual(sut.textStyles.integer.color, .green)
        XCTAssertEqual(sut.textStyles.integer.kern, 0.0)
        XCTAssertEqual(sut.textStyles.integer.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.textStyles.decimal.fontSize, .size(13, .medium))
        XCTAssertEqual(sut.textStyles.decimal.color, .black)
        XCTAssertEqual(sut.textStyles.decimal.kern, 1.1)
        XCTAssertEqual(sut.textStyles.decimal.verticalAlignment, .bottom(2))
        
        XCTAssertEqual(sut.textStyles.decimalSeparator.fontSize, .font(.preferredFont(forTextStyle: .caption2)))
        XCTAssertEqual(sut.textStyles.decimalSeparator.color, .brown)
        XCTAssertEqual(sut.textStyles.decimalSeparator.kern, 1.3)
        XCTAssertEqual(sut.textStyles.decimalSeparator.verticalAlignment, .baseline(0))
        
        XCTAssertEqual(sut.textStyles.currency.fontSize, .size(12, .semibold))
        XCTAssertEqual(sut.textStyles.currency.color, .red)
        XCTAssertEqual(sut.textStyles.currency.kern, 0.0)
        XCTAssertEqual(sut.textStyles.currency.verticalAlignment, .baseline(0))
    }
}
