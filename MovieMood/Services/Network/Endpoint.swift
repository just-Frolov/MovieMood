//
//  Endpoint.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import Alamofire

class Endpoint<T: Decodable>: Requestable {

    typealias Response = T
    
    let path: ClNetwork.EndpointPath
    var parameters: [String: Any] = [:]
    let method: HTTPMethod
    let encoding: ParameterEncoding
    
    init(
        path: ClNetwork.EndpointPath,
        parameters: [String: Any],
        method: HTTPMethod,
        encoding: ParameterEncoding = URLEncoding.default
    ) {
        self.path = path
        self.parameters = parameters
        self.method = method
        self.encoding = encoding
    }
}
