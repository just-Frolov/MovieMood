//
//  MovieDetailsRequest.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import Alamofire

final class MovieDetailsRequest: Endpoint<MovieDetails> {
    init(path: ClNetwork.EndpointPath) {
        super.init(
            path: path,
            method: .get,
            encoding: URLEncoding.default
        )
    }
}

