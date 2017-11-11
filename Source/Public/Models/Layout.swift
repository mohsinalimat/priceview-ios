//
//  Layout.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/11/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public struct Layout {
    
    // MARK: - Nested
    
    public enum VerticalAlignment {
        case top
        case bottom
        case middle
    }
    
    // MARK: - Properties
    
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: NSTextAlignment
    let currencySpacing: CGFloat
    let decimalSeparatorSpacing: (leading: CGFloat, trailing: CGFloat)
    
    // MARK: - Initializer
    
    public init(verticalAlignment: VerticalAlignment = .middle,
                horizontalAlignment: NSTextAlignment = .center,
                currencySpacing: CGFloat = 0,
                decimalSeparatorSpacing: (leading: CGFloat, trailing: CGFloat) = (leading: 0, trailing: 0)
    ) {
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.currencySpacing = currencySpacing
        self.decimalSeparatorSpacing = decimalSeparatorSpacing
    }
}
