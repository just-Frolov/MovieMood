//
//  Optional+Extension.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import Foundation

extension Optional where Wrapped: Collection {
    /// Check if optional is nil or empty collection.
    var isNilOrEmpty: Bool {
        guard let collection = self else { return true }
        return collection.isEmpty
    }
}
