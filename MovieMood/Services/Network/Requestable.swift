//
//  Requestable.swift
//  MovieMood
//
//  Created by Danil Frolov on 29.04.2023.
//

import Alamofire

protocol Requestable {
    
    associatedtype Response: Decodable
    
    var path: ClNetwork.EndpointPath { get }
    var parameters: [String: Any] { get set }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}
