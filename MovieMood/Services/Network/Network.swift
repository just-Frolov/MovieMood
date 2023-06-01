//
//  Network.swift
//  MovieMood
//
//  Created by Danil Frolov on 29.04.2023.
//

import Alamofire
import UIKit

protocol Network: AnyObject {
    func request<T: Requestable>(endpoint: T) async throws -> T.Response
}

final class ClNetwork: Network {
    
    private enum Constants {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let kApiKey = "api_key="
        static let apiKey = "a5e9b83ceecaed49515d68d344c79b72"
    }
    
    func request<T: Requestable>(endpoint: T) async throws -> T.Response {
        guard let url = URL(string: endpoint.path.fullURL()) else {
            throw ClError.invalidUrl
        }
        
        let task = AF.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding
        )
            .validate()
            .serializingDecodable(T.Response.self)
        let response = await task.response
        let result = response.result
        switch result {
        case .success(let items):
            Logger.debug("\(url.absoluteString)\n\(items)")
            return items
            
        case .failure(let afError):
            Logger.error("\(url.absoluteString)\n\(afError.localizedDescription)")
            throw afError
        }
    }
}

extension ClNetwork {
    enum EndpointPath {
        case movieList
        
        private var path: String {
            switch self {
            case .movieList:
                return "discover/movie"
            }
        }
    
        func fullURL() -> String {
            return String(format: "%@%@?%@%@",
                          Constants.baseURL,
                          self.path,
                          Constants.kApiKey,
                          Constants.apiKey)
        }
    }
}

enum ClError: Error {
    case invalidUrl
    case invalidParameters
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return Localized.urlNotValid
            
        case .invalidParameters:
            return Localized.invalidRequestParams
        }
    }
}
