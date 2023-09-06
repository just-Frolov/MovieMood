//
//  ImageManager.swift
//  MovieMood
//
//  Created by Danil Frolov on 06.07.2023.
//

import Foundation

struct ImageManager {
    
    private enum Constant {
        static let baseURL = "https://image.tmdb.org"
        static let baseURLPrefix = "/t/p/"
    }

    enum ImageSizeType: String {
        case list = "w500"
        case details = "original"
    }

    static func imageURL(withPath path: String, imageSizeType: ImageSizeType) -> URL? {
        var urlComponents = URLComponents(string: Constant.baseURL)
        urlComponents?.path = Constant.baseURLPrefix + imageSizeType.rawValue + path
        return urlComponents?.url
    }
}
