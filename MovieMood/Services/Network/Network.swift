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
    
    private enum Constant {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let apiDictionarySecretKey = "API_KEY"
        static let apiSecretKey = "api_key"
    }
    
    func request<T: Requestable>(endpoint: T) async throws -> T.Response {
        guard let url = endpoint.path.fullURL else {
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
        case movieList(sortType: MovieListSortType, page: Int)
        case movieSearch(query: String, page: Int)
        case movieDetails(id: MovieId)
        case movieVideoList(id: MovieId)
        
        private var path: String {
            switch self {
            case .movieList:
                return APIConstant.MovieListField.path
            case .movieSearch:
                return APIConstant.MovieSearchField.path
            case .movieDetails(let id):
                return APIConstant.MovieDetailsField.path(by: id)
            case .movieVideoList(let id):
                return APIConstant.MovieVideoListField.path(by: id)
            }
        }
        
        private var queryItems: [URLQueryItem]? {
            switch self {
            case .movieList(let sortType, let page):
                return [
                    URLQueryItem(
                        name: APIConstant.MovieListField.sortType,
                        value: sortType.rawValue
                    ),
                    URLQueryItem(
                        name: APIConstant.MovieListField.page,
                        value: String(page)
                    )
                ]
            case .movieSearch(let query, let page):
                return [
                    URLQueryItem(
                        name: APIConstant.MovieSearchField.query,
                        value: query
                    ),
                    URLQueryItem(
                        name: APIConstant.MovieSearchField.page,
                        value: String(page)
                    )
                ]
            case .movieDetails, .movieVideoList:
                return nil
            }
        }
            
        var fullURL: URL? {
            var fullURL = URLComponents(string: Constant.baseURL + self.path)
            let apiKey = Bundle.main.object(forInfoDictionaryKey: Constant.apiDictionarySecretKey) as? String
            let apiKeyQueryItem = URLQueryItem(name: Constant.apiSecretKey, value: apiKey)
            fullURL?.queryItems = [apiKeyQueryItem]
            
            if let queryItems {
                fullURL?.queryItems?.append(contentsOf: queryItems)
            }
            
            return fullURL?.url
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
