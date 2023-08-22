//
//  MovieVideoListEntity.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import Foundation

struct MovieVideoList: Codable {
    let results: [MovieVideo]
}

struct MovieVideo: Codable {
    let name: String
    let key: String
    let official: Bool
    let publicationDate: String

    enum CodingKeys: String, CodingKey {
        case name
        case key
        case official
        case publicationDate = "published_at"
    }
}
