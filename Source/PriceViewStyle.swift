//
//  PriceViewStyle.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public struct PriceViewStyle {
    
    enum SymbolPosition {
        case beforeCurrency
        case afterCurrency
    }
    
    let integerTextStyle: TextStyle
    let decimalTextStyle: TextStyle
    let decimalSeparatorTextStyle: TextStyle
    let currencyTextStyle: TextStyle
    
    let decimalSeparatorSpacing: (leading: CGFloat, trailing: CGFloat)
    let currencySpacing: CGFloat
    
    private(set) var alignment: TextVerticalAlignment?
    
    let locale: Locale
    
    var symbolPosition: SymbolPosition {
        if locale.regionCode == "US" {
            return .beforeCurrency
        } else {
            return .afterCurrency
        }
    }
    
    public init(integerTextStyle: TextStyle,
                decimalTextStyle: TextStyle,
                decimalSeparatorTextStyle: TextStyle,
                currencyTextStyle: TextStyle,
                decimalSeparatorSpacing: (CGFloat, CGFloat) = (0, 0),
                currencySpacing: CGFloat = 0,
                alignment: TextVerticalAlignment = .middle(0),
                locale: Locale = NSLocale.current
    ) {
        self.integerTextStyle = integerTextStyle
        self.decimalTextStyle = decimalTextStyle
        self.decimalSeparatorTextStyle = decimalSeparatorTextStyle
        self.currencyTextStyle = currencyTextStyle
        self.decimalSeparatorSpacing = decimalSeparatorSpacing
        self.currencySpacing = currencySpacing
        self.locale = locale
        self.alignment = alignment
    }
}
