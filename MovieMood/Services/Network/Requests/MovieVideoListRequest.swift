//
//  MovieVideoListRequest.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import Alamofire

final class MovieVideoListRequest: Endpoint<MovieVideosResponse> {
    init(path: ClNetwork.EndpointPath) {
        super.init(path: path, method: .get)
    }
}
