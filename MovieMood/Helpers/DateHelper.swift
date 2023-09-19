//
//  DateHelper.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import Foundation

final class DateHelper {
    
    static private let formatter = DateFormatter()

    static func toServerDate(from string: String) -> Date? {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.date(from: string)
    }
    
    static func toDateWithoutTime(from date: Date) -> String? {
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }
}
