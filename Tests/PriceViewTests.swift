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
            verifySnap(with: value)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
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
            verifySnap(with: value, style: style)
        }
    }
    
    func testPriceTopAlignment() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .top(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .top(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            currencySpacing: 3,
            verticalAlignment: .top
        )
        
        for value in testValues {
            verifySnap(with: value, style: style, center: false)
        }
    }
    
    func testPriceBottomLeftAlignment() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .middle(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .top(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            currencySpacing: 3,
            verticalAlignment: .bottom,
            textAlignment: .left
        )
        
        for value in testValues {
            verifySnap(with: value, style: style, center: false)
        }
    }
    
    func testPriceMiddleRightAlignment() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .baseline(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .top(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            currencySpacing: 3,
            verticalAlignment: .middle,
            textAlignment: .right
        )
        
        for value in testValues {
            verifySnap(with: value, style: style, center: false)
        }
    }

    func testPriceMiddleAlignment() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .baseline(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .top(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            currencySpacing: 3,
            verticalAlignment: .middle
        )
        
        for value in testValues {
            verifySnap(with: value, style: style, center: false)
        }
    }

    func testPriceTopRightAlignment() {
        let secondaryTextStyle = TextStyle(size: 14,
                                           color: .darkGray,
                                           verticalAlignment: .baseline(0))
        let style = PriceViewStyle(
            integerTextStyle:
            TextStyle(size: 20,
                      color: .black,
                      verticalAlignment: .top(0)),
            decimalTextStyle: secondaryTextStyle,
            decimalSeparatorTextStyle: secondaryTextStyle,
            currencyTextStyle: secondaryTextStyle,
            currencySpacing: 3,
            verticalAlignment: .top,
            textAlignment: .right
            )
        
        for value in testValues {
            verifySnap(with: value, style: style, center: false)
        }
    }
    
    // Symbol position with given locale
    // Thousand separator given locale
    
    // MARK: - Private
    
    private func verifySnap(with price: Double,
                           style: PriceViewStyle = UIPriceView().style,
                           size: CGSize = CGSize(width: 200, height: 120),
                           center: Bool = true) {
        let view = UIView()
        let testView = UIView(frame: CGRect(origin: .zero, size: size))
        let priceView = UIPriceView(style: style)
        view.addSubview(testView)
        testView.addSubview(priceView)
        priceView.translatesAutoresizingMaskIntoConstraints = false
        
        if center {
            NSLayoutConstraint.activate([
                priceView.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
                priceView.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                priceView.topAnchor.constraint(equalTo: testView.topAnchor),
                priceView.leftAnchor.constraint(equalTo: testView.leftAnchor),
                priceView.rightAnchor.constraint(equalTo: testView.rightAnchor),
                priceView.bottomAnchor.constraint(equalTo: testView.bottomAnchor)
            ])
        }
        
        priceView.price = price
        
        FBSnapshotVerifyView(testView, identifier: "\(price)")
    }
}
