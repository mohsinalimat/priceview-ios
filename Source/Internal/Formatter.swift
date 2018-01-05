//
//  Formatter.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/7/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

final class Formatter {
    
    private let style: Style
    private let locale: Locale
    
    init(with style: Style, locale: Locale) {
        self.style = style
        self.locale = locale
    }
    
    var currencySymbol: String {
        return locale.currencySymbol ?? ""
    }
    
    var decimalSeparator: String {
        return locale.decimalSeparator ?? ""
    }
    
    func formattedInteger(price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.groupingSeparator = locale.groupingSeparator
        if style.fractionDigits < 2 {
            formatter.minimumFractionDigits = style.fractionDigits
        } else {
            formatter.numberStyle = .decimal
        }

        let formattedPrice = formatter.string(from: NSNumber(value: price)) ?? "\(price)"
        let splittedPrice = formattedPrice.split(separator: Character(decimalSeparator))
        
        return String(splittedPrice[0])
    }
    
    func formattedDecimal(price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.minimumFractionDigits = style.fractionDigits
        let formattedPrice = formatter.string(from: NSNumber(value: price)) ?? "\(price)"
        
        if formattedPrice.contains(Character(decimalSeparator)) {
            let splittedPrice = formattedPrice.split(separator: Character(decimalSeparator), maxSplits: 2)
            if let last = splittedPrice.last {
                return String(last)
            } else {
                return "oops"
            }
        } else {
            var res = ""
            for _ in 0..<style.fractionDigits {
                res += "0"
            }
            return res
        }
    }
}
