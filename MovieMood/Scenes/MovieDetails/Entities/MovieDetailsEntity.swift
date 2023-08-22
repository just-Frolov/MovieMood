//
//  MovieDetailsEntity.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import Foundation

struct MovieDetails: Codable {
    struct CountryName: Codable {
        var name: String
    }
    
    let id: MovieId
    let budget: Int
    let revenue: Int
    let productionCountries: [CountryName]
    let releaseDate: String?
    let backdropPath: String?
    let title: String
    let originalTitle: String
    let overview: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case budget
        case revenue
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case title
        case originalTitle = "original_title"
        case overview
        case voteAverage = "vote_average"
    }
}
