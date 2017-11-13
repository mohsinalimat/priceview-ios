//
//  Style.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public struct Style {
    
    // MARK: - Properties

    let textStyles: TextStyles
    let options: Options
    let layout: Layout
    
    // MARK: - Initializers
    
    public init(
        defaultTextStyle: TextStyle = TextStyle(size: 12, weight: .semibold, color: .black),
        layout: Layout = Layout(),
        options: Options = Options(),
        textStyles: TextStyleType...
    ) {
        self.textStyles = Style.makeTextStyles(defaultStyle: defaultTextStyle, textStyles: textStyles)
        self.layout = layout
        self.options = options
    }
    
    private static func makeTextStyles(defaultStyle: TextStyle, textStyles: [TextStyleType]) -> TextStyles {
        var tmp = TextStyles(defaultTextStyle: defaultStyle)
        
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
        
        return tmp
    }
    
    public init(integerTextStyle: TextStyle,
                decimalTextStyle: TextStyle,
                decimalSeparatorTextStyle: TextStyle,
                currencyTextStyle: TextStyle,
                decimalSeparatorSpacing: (leading: CGFloat, trailing: CGFloat) = (0, 0),
                currencySpacing: CGFloat = 0,
                fractionDigits: Int = 2,
                verticalAlignment: Layout.VerticalAlignment = .middle,
                textAlignment: NSTextAlignment = .center,
                locale: Locale = NSLocale.current
    ) {
        self.textStyles = TextStyles(integer: integerTextStyle,
                                     decimal: decimalTextStyle,
                                     decimalSeparator: decimalSeparatorTextStyle,
                                     currency: currencyTextStyle)
        self.layout = Layout(verticalAlignment: verticalAlignment, horizontalAlignment: textAlignment, currencySpacing: currencySpacing, decimalSeparatorSpacing: (leading: decimalSeparatorSpacing.leading, trailing: decimalSeparatorSpacing.trailing))
        self.options = Options(locale: locale, fractionDigits: fractionDigits)
    }
}
