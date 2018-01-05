//
//  TextStyle.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

public enum TextVerticalAlignment: Equatable {
    case top(CGFloat)
    case middle(CGFloat)
    case bottom(CGFloat)
    case baseline(CGFloat)
    
    public static func ==(lhs: TextVerticalAlignment, rhs: TextVerticalAlignment) -> Bool {
        switch (lhs, rhs) {
        case let (.top(a), .top(b)):
            return a == b
        case let (.middle(a), .middle(b)):
            return a == b
        case let (.bottom(a), .bottom(b)):
            return a == b
        case let (.baseline(a), .baseline(b)):
            return a == b
        default:
            return false
        }
    }
}

public struct TextStyle {
    let fontSize: FontSize
    let color: UIColor
    let kern: CGFloat
    let verticalAlignment: TextVerticalAlignment
    
    // MARK: - Initializers
    
    public init(size: CGFloat,
                weight: UIFont.Weight = .semibold,
                color: UIColor,
                kern: CGFloat = 0.0,
                verticalAlignment: TextVerticalAlignment = .baseline(0)
    ) {
        self.fontSize = .size(size, weight)
        self.color = color
        self.kern = kern
        self.verticalAlignment = verticalAlignment
    }
    
    public init(font: UIFont,
                color: UIColor,
                kern: CGFloat = 0.0,
                verticalAlignment: TextVerticalAlignment = .baseline(0)
    ) {
        self.fontSize = .font(font)
        self.color = color
        self.kern = kern
        self.verticalAlignment = verticalAlignment
    }
}

enum FontSize: Equatable {
    case font(UIFont)
    case size(CGFloat, UIFont.Weight)
    
    static func ==(lhs: FontSize, rhs: FontSize) -> Bool {
        switch (lhs, rhs) {
        case let (.font(a), .font(b)):
            return a == b
        case let (.size(sizeA, weightA), .size(sizeB, weightB)):
            return sizeA == sizeB && weightA == weightB
        default:
            return false
        }
    }
}
