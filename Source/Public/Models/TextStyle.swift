//
//  TextStyle.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

public enum TextVerticalAlignment {
    case top(CGFloat)
    case middle(CGFloat)
    case bottom(CGFloat)
    case baseline(CGFloat)
}

enum FontSize {
    case font(UIFont)
    case size(CGFloat, UIFont.Weight)
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
