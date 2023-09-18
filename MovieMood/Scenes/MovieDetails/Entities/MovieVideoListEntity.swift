//
//  MovieVideoListEntity.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import Foundation

struct MovieVideosResponse: Codable {
    let results: [MovieVideo]
}

struct MovieVideo: Codable {
    let name: String
    let key: String
    let official: Bool
    let publicationDate: Date?

    enum CodingKeys: String, CodingKey {
        case name
        case key
        case official
        case publicationDate = "published_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.key = try container.decode(String.self, forKey: .key)
        self.official = try container.decode(Bool.self, forKey: .official)
        let publicationDateString = try container.decode(String.self, forKey: .publicationDate)
        self.publicationDate = DateHelper.toServerDate(from: publicationDateString)
    }
}
