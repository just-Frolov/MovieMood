//
//  MovieSearchRequest.swift
//  MovieMood
//
//  Created by Danil Frolov on 30.08.2023.
//

import Alamofire

final class MovieSearchRequest: Endpoint<MovieList> {
    init(path: ClNetwork.EndpointPath) {
        super.init(path: path, method: .get)
    }
}
