//
//  MovieListRequest.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import Alamofire

final class MovieListRequest: Endpoint<[MovieList]> {
    enum SortType: String {
        case popularity = "popularity.desc"
    }

    init(
        path: ClNetwork.EndpointPath = .movieList,
        page: Int = 1,
        sortType: SortType = .popularity
    ) {
        super.init(
            path: path,
            parameters: MovieListRequest.toDictionary(
                page: page,
                sortType: sortType.rawValue
            ),
            method: .get,
            encoding: URLEncoding.default
        )
    }
}

private extension MovieListRequest {
    private enum Constants {
        static let kPage = "page"
        static let kSortType = "sort_by"
    }
    
    static private func toDictionary(page: Int, sortType: String) -> [String: Any] {
        let params: [String: Any] = [
            Constants.kPage: page,
            Constants.kSortType: sortType,
        ]
        return params
    }
}
