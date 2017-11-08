//
//  PriceTransformer.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

struct PriceTransformer {
    func transformedData(price: Double, locale: Locale = NSLocale.current) -> PriceData {
        // error handling
        let decimalSeparator = locale.decimalSeparator!
        let splittedPrice = String(price).split(separator: Character(decimalSeparator))
        let integerPart = Int64(splittedPrice[0])!
        let decimalPart = Int64(splittedPrice[1])!
        
        return PriceData(currencySymbol: locale.currencySymbol!, decimalSeparator: decimalSeparator, integerPart: integerPart, decimalPart: decimalPart, locale: locale)
    }
}
