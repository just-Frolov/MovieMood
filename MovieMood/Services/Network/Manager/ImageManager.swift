//
//  ImageManager.swift
//  MovieMood
//
//  Created by Danil Frolov on 06.07.2023.
//

import Foundation

struct ImageManager {
    static let shared = ImageManager()

    private enum Constants {
        static let baseURL = "https://image.tmdb.org"
        static let baseURLPrefix = "/t/p/"
    }

    enum ImageSizeType: String {
        case list = "w500"
        case details = "original"
    }

    func imageURL(withPath path: String, imageSizeType: ImageSizeType) -> URL? {
        var urlComponents = URLComponents(string: Constants.baseURL)
        urlComponents?.path = Constants.baseURLPrefix + imageSizeType.rawValue + path
        return urlComponents?.url
    }
}
