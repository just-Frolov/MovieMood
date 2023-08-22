//
//  MovieListRequest.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import Alamofire

final class MovieListRequest: Endpoint<MovieList> {
    enum SortType: String {
        case popularity = "popularity.desc"
        case vote = "vote_average"
    }

    init(
        page: Int,
        sortType: SortType
    ) {
        super.init(
            path: .movieList,
            parameters: MovieListRequest.paramsToDictionary(
                page: page,
                sortType: sortType.rawValue
            ),
            method: .get,
            encoding: URLEncoding.default
        )
    }
}

private extension MovieListRequest {
    //RETHINK
    static func paramsToDictionary(page: Int, sortType: String) -> [String: Any] {
        let params: [String: Any] = [
            APIConstants.MovieListFields.page: page,
            APIConstants.MovieListFields.sortType: sortType,
        ]
        return params
    }
}
