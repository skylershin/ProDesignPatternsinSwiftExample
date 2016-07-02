//
//  StockValueImplementations.swift
//  SportsStore
//
//  Created by MunkyuShin on 6/26/16.
//  Copyright © 2016 munkyu. All rights reserved.
//

import Foundation

protocol StockValueFormatter {
    func formatTotal(total:Double) -> String
}

class DollarStockValueFormatter : StockValueFormatter {
    func formatTotal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(total)
        return "\(formatted)"
    }
}

class PoundStockValueFormatter: StockValueFormatter {
    func formatTotal(total: Double) -> String {
        var formatted = Utils.currencyStringFromNumber(total)
        formatted.removeAtIndex(formatted.startIndex)
        return "£\(formatted)"
    }
}

protocol StockValueConverter {
    func convertTotal(total:Double) -> Double
}

class DollarStockValueConverter: StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return total
    }
}

class PoundStockValueConverter: StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return 0.60338 * total
    }
}