//
//  PriceFormatter.swift
//  MovieMood
//
//  Created by Danil Frolov on 23.08.2023.
//

import Foundation

final class PriceFormatter {
    static private let formatter = NumberFormatter()
    
    /// `$100,000,000` instead of `100000000`
    static func toDecimalWithUSD(from value: Int) -> String {
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? ""
        return formattedValue
    }
}
