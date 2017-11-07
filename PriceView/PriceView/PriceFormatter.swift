//
//  PriceFormatter.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

final class PriceFormatter: NumberFormatter {
    override init() {
        super.init()
        groupingSeparator = ","
        numberStyle = .decimal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("--")
    }
}
