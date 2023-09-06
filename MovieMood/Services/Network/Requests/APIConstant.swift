//
//  APIConstant.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.07.2023.
//

import Foundation

enum APIConstant {
    enum MovieListField {
        static func path(by id: MovieId) -> String {
            return "discover/movie" + String(id)
        }
        
        static let path = "discover/movie"
        static let page = "page"
        static let sortType = "sort_by"
    }
    
    enum MovieSearchField {
        static let path = "search/movie"
        static let query = "query"
        static let page = "page"
    }
    
    enum MovieDetailsField {
        static func path(by id: MovieId) -> String {
            return "movie/" + String(id)
        }
    }
    
    enum MovieVideoListField {
        static func path(by id: MovieId) -> String {
            return "movie/\(id)/videos"
        }
    }
}
