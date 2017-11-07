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
    
    var integerTextStyle: TextStyle
    var decimalTextStyle: TextStyle
    var decimalSeparatorTextStyle: TextStyle
    var currencyTextStyle: TextStyle
    var locale: Locale
    
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
                locale: Locale = NSLocale.current
    ) {
        self.integerTextStyle = integerTextStyle
        self.decimalTextStyle = decimalTextStyle
        self.decimalSeparatorTextStyle = decimalSeparatorTextStyle
        self.currencyTextStyle = currencyTextStyle
        self.locale = locale
    }
}
