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
        static let apiDictionarySecretKey = "API_KEY"
        static let apiSecretKey = "api_key"
    }
    
    func request<T: Requestable>(endpoint: T) async throws -> T.Response {
        guard let url = endpoint.path.baseURL else {
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
            throw ClError.unknown 
        }
    }
}

extension ClNetwork {
    enum EndpointPath {
        case movieList
        
        private var path: String {
            switch self {
            case .movieList:
                return APIConstants.MovieListFields.path
            }
        }
    
        var baseURL: URL? {
            var baseURL = URLComponents(string: Constants.baseURL + self.path)
            let apiKey = Bundle.main.object(forInfoDictionaryKey: Constants.apiDictionarySecretKey) as? String
            let apiKeyQueryItem = URLQueryItem(name: Constants.apiSecretKey, value: apiKey)
            baseURL?.queryItems = [apiKeyQueryItem]
            return baseURL?.url
        }
    }
}

enum ClError: Error {
    case unknown
    case invalidUrl
    case invalidParameters
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return Localized.defaultError
            
        case .invalidUrl:
            return Localized.urlNotValid
            
        case .invalidParameters:
            return Localized.invalidRequestParams
        }
    }
}
