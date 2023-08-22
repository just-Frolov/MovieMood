//
//  APIConstants.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.07.2023.
//

import Foundation

enum APIConstants { 
    enum MovieListFields {
        static let path = "discover/movie"
        static let page = "page"
        static let sortType = "sort_by"
    }
    
    enum MovieDetailsFields {
        static func path(by id: MovieId) -> String {
            return "movie/" + String(id)
        }
    }
    
    enum MovieVideoListFields {
        static func path(by id: MovieId) -> String {
            return "movie/\(id)/videos"
        }
    }
}
