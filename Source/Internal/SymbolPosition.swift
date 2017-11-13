//
//  SymbolPosition
//  PriceView
//
//  Created by Thomas Sivilay on 11/13/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

enum SymbolPosition: Equatable {
    case beforeCurrency
    case afterCurrency
    
    init(with locale: Locale) {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        
        if let formattedString = formatter.string(from: NSNumber(value: 1)), let symbol = formatter.currencySymbol {
            if formattedString.starts(with: symbol) {
                self = .beforeCurrency
            } else {
                self = .afterCurrency
            }
        } else {
            self = .afterCurrency
        }
    }
}
