//
//  Style.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public struct Style {
    
    // MARK: - Nested
    
    public enum VerticalAlignment {
        case top
        case bottom
        case middle
    }
    
    enum SymbolPosition {
        case beforeCurrency
        case afterCurrency
    }
    
    public enum TextStyleType {
        case integer(TextStyle)
        case decimal(TextStyle)
        case decimalSeparator(TextStyle)
        case currency(TextStyle)
    }

    struct TextStyles {
        var integer: TextStyle
        var decimal: TextStyle
        var decimalSeparator: TextStyle
        var currency: TextStyle
        
        init(defaultTextStyle: TextStyle) {
            self.integer = defaultTextStyle
            self.decimal = defaultTextStyle
            self.decimalSeparator = defaultTextStyle
            self.currency = defaultTextStyle
        }
        
        init(integer: TextStyle,
             decimal: TextStyle,
             decimalSeparator: TextStyle,
             currency: TextStyle) {
            self.integer = integer
            self.decimal = decimal
            self.decimalSeparator = decimalSeparator
            self.currency = currency
        }
    }
    
    // MARK: - Internal

    let textStyles: TextStyles
    let numberFraction: Int
    let locale: Locale
    let textAlignment: NSTextAlignment
    let verticalAlignment: VerticalAlignment
    
    let decimalSeparatorSpacing: (leading: CGFloat, trailing: CGFloat)
    let currencySpacing: CGFloat

    var symbolPosition: SymbolPosition {
        if locale.regionCode == "US" {
            return .beforeCurrency
        } else {
            return .afterCurrency
        }
    }
    
    
    // MARK: - Initializers
    
    public init(
        defaultTextStyle: TextStyle = TextStyle(size: 12, color: .black),
        decimalSeparatorSpacing: (CGFloat, CGFloat) = (0, 0),
        currencySpacing: CGFloat = 0,
        numberFraction: Int = 2,
        verticalAlignment: VerticalAlignment = .middle,
        textAlignment: NSTextAlignment = .center,
        locale: Locale = .current,
        textStyles: TextStyleType...
    ) {
        var tmp = TextStyles(defaultTextStyle: defaultTextStyle)
        
        for textStyle in textStyles {
            switch textStyle {
            case .currency(let style):
                tmp.currency = style
            case .decimal(let style):
                tmp.decimal = style
            case .decimalSeparator(let style):
                tmp.decimalSeparator = style
            case .integer(let style):
                tmp.integer = style
            }
        }
        
        self.textStyles = tmp
        self.decimalSeparatorSpacing = decimalSeparatorSpacing
        self.currencySpacing = currencySpacing
        self.numberFraction = numberFraction
        self.verticalAlignment = verticalAlignment
        self.textAlignment = textAlignment
        self.locale = locale
    }
    
    public init(integerTextStyle: TextStyle,
                decimalTextStyle: TextStyle,
                decimalSeparatorTextStyle: TextStyle,
                currencyTextStyle: TextStyle,
                decimalSeparatorSpacing: (CGFloat, CGFloat) = (0, 0),
                currencySpacing: CGFloat = 0,
                numberFraction: Int = 2,
                verticalAlignment: VerticalAlignment = .middle,
                textAlignment: NSTextAlignment = .center,
                locale: Locale = NSLocale.current
    ) {
        self.textStyles = TextStyles(integer: integerTextStyle,
                                     decimal: decimalTextStyle,
                                     decimalSeparator: decimalSeparatorTextStyle,
                                     currency: currencyTextStyle)
        self.decimalSeparatorSpacing = decimalSeparatorSpacing
        self.currencySpacing = currencySpacing
        self.numberFraction = numberFraction
        self.verticalAlignment = verticalAlignment
        self.textAlignment = textAlignment
        self.locale = locale
    }
}
