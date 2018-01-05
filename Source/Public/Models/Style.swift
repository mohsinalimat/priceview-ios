//
//  Style.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public enum StyleElement {
    case verticalAlignment(Style.VerticalAlignment)
    case horizontalAlignment(NSTextAlignment)
    case currencySpacing(CGFloat)
    case decimalSeparatorSpacing(leading: CGFloat, trailing: CGFloat)
    case fractionDigits(Int)
    case integer(TextStyle)
    case decimal(TextStyle)
    case decimalSeparator(TextStyle)
    case currency(TextStyle)
}

public struct Style {
    
    public enum VerticalAlignment {
        case top
        case bottom
        case middle
    }
    
    // MARK: - Properties
    
    var integer: TextStyle
    var decimal: TextStyle
    var decimalSeparator: TextStyle
    var currency: TextStyle
    
    var fractionDigits: Int = 2
    
    var verticalAlignment: VerticalAlignment = .middle
    var horizontalAlignment: NSTextAlignment = .center
    var currencySpacing: CGFloat = 0
    var decimalSeparatorSpacing: (leading: CGFloat, trailing: CGFloat) = (leading: 0, trailing: 0)
    
    // MARK: - Initializers
    
    public init(defaultTextStyle: TextStyle = TextStyle(font: UIFont.preferredFont(forTextStyle: .body), color: .black, kern: 0.0, verticalAlignment: .baseline(0)),
                elements: StyleElement...) {
        self.integer = defaultTextStyle
        self.currency = defaultTextStyle
        self.decimal = defaultTextStyle
        self.decimalSeparator = defaultTextStyle
        for element in elements {
            switch element {
            case .verticalAlignment(let value):
                self.verticalAlignment = value
            case .horizontalAlignment(let value):
                self.horizontalAlignment = value
            case .currencySpacing(let value):
                self.currencySpacing = value
            case .decimalSeparatorSpacing(leading: let leading, trailing: let trailing):
                self.decimalSeparatorSpacing = (leading: leading, trailing: trailing)
            case .fractionDigits(let value):
                self.fractionDigits = value
            case .integer(let value):
                self.integer = value
            case .decimal(let value):
                self.decimal = value
            case .decimalSeparator(let value):
                self.decimalSeparator = value
            case .currency(let value):
                self.currency = value
            }
        }
    }
}
