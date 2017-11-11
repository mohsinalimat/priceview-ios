//
//  TextStyles.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/11/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

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
