//
//  Reusable.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import Foundation

protocol Reusable { }

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
