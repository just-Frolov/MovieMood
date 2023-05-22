//
//  SplashScreenEntity.swift
//  MovieMood
//
//  Created by Danil Frolov on 30.04.2023.
//

import Foundation

struct MovieResponce: Codable {
    let results: [Movie]
    
    struct Movie: Codable {
        let backdropPath: String?
        let genreIDS: [Int]
        let id: Int
        let releaseDate: String?
        let title: String
        let voteAverage: Double
        
        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case releaseDate = "release_date"
            case title
            case voteAverage = "vote_average"
        }
    }
}


