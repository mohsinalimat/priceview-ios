//
//  TextStyle.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public struct TextStyle {
    var size: CGFloat
    var color: UIColor
    var kern: CGFloat
    
    var baselineOffset: CGFloat
    var leadingOffset: CGFloat
    var trailingOffset: CGFloat
    
    public init(size: CGFloat,
         color: UIColor,
         kern: CGFloat = 0.0,
         baselineOffset: CGFloat = 0,
         leadingOffset: CGFloat = 0,
         trailingOffset: CGFloat = 0
    ) {
        self.size = size
        self.color = color
        self.kern = kern
        self.baselineOffset = baselineOffset
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}
