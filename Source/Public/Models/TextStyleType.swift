//
//  TextStyleType.swift
//  PriceView
//
//  Created by Thomas Sivilay on 11/11/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public enum TextStyleType {
    case integer(TextStyle)
    case decimal(TextStyle)
    case decimalSeparator(TextStyle)
    case currency(TextStyle)
}
