//
//  PriceData.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

struct PriceData {
    let currencySymbol: String
    let decimalSeparator: String
    let integerPart: Int64
    let decimalPart: Int64
    let locale: Locale
}
