//
//  MovieListRequest.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import Alamofire

final class MovieListRequest: Endpoint<MoviesResponse> {
    init(path: ClNetwork.EndpointPath) {
        super.init(
            path: path,
            method: .get
        )
    }
}
