//
//  Options.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/11/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public struct Options {
    var fractionDigits: Int
    
    public init(fractionDigits: Int = 2) {
        self.fractionDigits = fractionDigits
    }
}
