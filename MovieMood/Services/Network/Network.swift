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
    func uploadRequest<T: Requestable>(endpoint: T) async throws -> T.Response
    func requestData(for url: URL) async -> Result<Data, Error>
}

final class ClNetwork: Network {
    private let baseEndpoint = "https://shrouded-plateau-41640.herokuapp.com/api/v1/"
    
    func request<T: Requestable>(endpoint: T) async throws -> T.Response {
        guard let url = URL(string: baseEndpoint.appending(endpoint.path.path)) else {
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
    
    func requestData(for url: URL) async -> Result<Data, Error> {
        let task = AF.request(url)
            .validate()
            .serializingData()
        let response = await task.response
        let result = response.result
        
        switch result {
        case .success(let data):
            Logger.debug("\(url.absoluteString)\n\nLoaded data of \(data.count) bytes")
            return .success(data)
            
        case .failure(let afError):
            Logger.error("\(url.absoluteString)\n\(afError.localizedDescription)")
            return .failure(afError)
        }
    }
    
    func uploadRequest<T: Requestable>(endpoint: T) async throws -> T.Response {
        guard let url = URL(string: baseEndpoint.appending(endpoint.path.path)) else {
            throw ClError.invalidUrl
        }
        
        let headers = HTTPHeaders(
            [
                "Content-type": "multipart/form-data",
                "Content-Disposition": "form-data"
            ]
        )
        
        let request = try URLRequest(url: url, method: .put)
        guard let params = endpoint.parameters as? [String: Data] else {
            throw ClError.invalidParameters
        }
        let task = AF.upload(
            multipartFormData: { multipartData in
                for (key, value) in params {
                    if key == "file" {
                        multipartData.append(
                            value,
                            withName: key,
                            fileName: "image.png",
                            mimeType: "image/png"
                        )
                    } else {
                        multipartData.append(value, withName: key)
                    }
                }
            },
            to: url,
            method: .put,
            headers: headers
        )
            .validate()
            .serializingDecodable(T.Response.self)
        let response = await task.response
        let result = response.result
        
        switch result {
        case .success(let imageProgress):
            Logger.debug("\(url.absoluteString)\n\(imageProgress)")
            return imageProgress
            
        case .failure(let afError):
            Logger.error("\(url.absoluteString)\n\(afError.localizedDescription)")
            throw afError
        }
    }
}

extension ClNetwork {
    enum EndpointPath {
        case categories
        case imagesInCategory(String)
        case imagesProgressInCategory(String, String)
        case userImagesProgress(String, String)
        
        var path: String {
            switch self {
            case .categories:
                return "categories"
                
            case .imagesInCategory(let categoryId):
                return "images/by-category/\(categoryId)"
                
            case .imagesProgressInCategory(let categoryId, let userId):
                return "user-images-progress/by-category/\(categoryId)/user/\(userId)"
                
            case .userImagesProgress(let imageId, let userId):
                return "user-images-progress/\(imageId)/user/\(userId)"
            }
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
