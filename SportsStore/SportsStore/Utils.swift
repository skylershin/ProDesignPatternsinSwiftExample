//
//  Utils.swift
//  SportsStore
//
//  Created by MunkyuShin on 4/17/16.
//  Copyright © 2016 munkyu. All rights reserved.
//

import Foundation

class Utils {
    
    class func currencyStringFromNumber(number:Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(number) ?? ""
    }
}
