//
//  MovieListRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 04.10.2023.
//

import Foundation

protocol MovieListRouter where Self: BaseRouter<Assembly> {
    func showMovieDetails(with configuration: MovieDetailsConfiguration)
}

final class MovieListRouterImpl: BaseRouter<Assembly>, MovieListRouter {
    func showMovieDetails(with configuration: MovieDetailsConfiguration) {
        let movieDetailsViewController = assembly.createMovieDetailsModule(configuration: configuration)
        
        root.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
