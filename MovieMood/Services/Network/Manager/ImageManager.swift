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
        static let baseURL = "https://image.tmdb.org/t/p"
        static let imageSize = "/w500"
    }
    
    func imageURL(withPath path: String) -> URL? {
        let fullURLString = "\(Constants.baseURL)\(Constants.imageSize)\(path)"
        return URL(string: fullURLString)
    }
}
