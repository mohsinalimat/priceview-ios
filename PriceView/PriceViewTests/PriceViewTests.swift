//
//  PriceViewTests.swift
//  PriceViewTests
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import PriceView

class PriceViewTests: FBSnapshotTestCase {
    
    private let testValues = [
        1,
        12,
        123,
        1234,
        1235,
        12456,
        0,
        -1,
        -10,
        -123,
        1.0,
        1.2,
        1.23,
        123.456,
        -123.456,
        1234567891011
    ]
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    // MARK: - Tests
    
    func testDefaultStyle() {
        for value in testValues {
            let identifier = "WithValue_\(value)"
            let sut = buildAutoLayoutView(with: value)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testFoolishAlignment() {
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 32,
                      color: .black,
                      kern: 1.3,
                      verticalAlignment: .bottom(0)),
            decimalTextStyle:
            TextStyle(size: 18,
                      color: .lightGray,
                      kern: 0,
                      verticalAlignment: .top(0)),
            decimalSeparatorTextStyle:
            TextStyle(size: 18,
                      color: .darkGray,
                      kern: 0,
                      verticalAlignment: .middle(0)),
            currencyTextStyle:
            TextStyle(size: 20,
                      color: .darkGray,
                      kern: 0,
                      verticalAlignment: .bottom(0))
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testDecimalAndSeparatorTopAlignment() {
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 32,
                      color: .black,
                      kern: 1.3,
                      verticalAlignment: .bottom(0)),
            decimalTextStyle:
            TextStyle(size: 18,
                      color: .lightGray,
                      kern: 0,
                      verticalAlignment: .top(0)),
            decimalSeparatorTextStyle:
            TextStyle(size: 18,
                      color: .darkGray,
                      kern: 0,
                      verticalAlignment: .top(0)),
            currencyTextStyle:
            TextStyle(size: 20,
                      color: .darkGray,
                      kern: 0,
                      verticalAlignment: .bottom(0))
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testDecimalAndSeparatorTopAlignmentWithOffset() {
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 24,
                      color: .black,
                      kern: 1.3,
                      verticalAlignment: .bottom(0)),
            decimalTextStyle:
            TextStyle(size: 18,
                      color: .lightGray,
                      kern: 0,
                      verticalAlignment: .top(3)),
            decimalSeparatorTextStyle:
            TextStyle(size: 18,
                      color: .darkGray,
                      kern: 0,
                      verticalAlignment: .top(3)),
            currencyTextStyle:
            TextStyle(size: 20,
                      color: .darkGray,
                      kern: 0,
                      verticalAlignment: .bottom(0))
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testMiddleAlignment() {
        let secondaryTextStyle = TextStyle(size: 16, color: .gray, kern: 1.1, verticalAlignment: .middle(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 28,
                      color: .black,
                      kern: 1.3,
                      verticalAlignment: .bottom(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testBottomAlignment() {
        let secondaryTextStyle = TextStyle(size: 15,
                                           color: .gray,
                                           verticalAlignment: .bottom(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      kern: 0,
                      verticalAlignment: .bottom(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testBaselineAlignment() {
        let secondaryTextStyle = TextStyle(size: 13,
                                           color: .darkGray,
                                           verticalAlignment: .baseline(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      kern: 0,
                      verticalAlignment: .baseline(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testSeparatorSpacing() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .baseline(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .baseline(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            decimalSeparatorSpacing: (12,3)
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testSeparatorNegativeSpacing() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .baseline(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .baseline(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            decimalSeparatorSpacing: (2,-1)
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    func testCurrencySpacing() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .middle(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .middle(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            currencySpacing: 6
        )
        
        for value in testValues {
            let identifier = "\(value)"
            let sut = buildAutoLayoutView(with: value, style: style)
            FBSnapshotVerifyView(sut, identifier: identifier)
        }
    }
    
    // Symbol position with given locale
    // Thousand separator given locale
    // Text vertical alignement???
    // Text horizontal alignment??? -> Play with constraint constant.
    
    // MARK: - Private
    
    private func buildAutoLayoutView(with price: Double, style: PriceViewStyle? = nil) -> UIView {
        let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        let view = UIView(frame: rect)
        var priceView = UIPriceView()
        
        if let style = style {
            priceView = UIPriceView(style: style)
        }
        view.addSubview(priceView)
        priceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            priceView.topAnchor.constraint(equalTo: view.topAnchor),
//            priceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            priceView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            priceView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        priceView.price = price
        
        return view
    }
}
