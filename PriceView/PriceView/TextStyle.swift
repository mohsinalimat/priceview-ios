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

public struct TextStyle {
    let size: CGFloat
    let color: UIColor
    let kern: CGFloat
    
    let verticalAlignment: TextVerticalAlignment

    
    var leadingOffset: CGFloat
    var trailingOffset: CGFloat
    
    public init(size: CGFloat,
         color: UIColor,
         kern: CGFloat = 0.0,
         verticalAlignment: TextVerticalAlignment = .baseline(0),
         leadingOffset: CGFloat = 0,
         trailingOffset: CGFloat = 0
    ) {
        self.size = size
        self.color = color
        self.kern = kern
        self.verticalAlignment = verticalAlignment
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}
