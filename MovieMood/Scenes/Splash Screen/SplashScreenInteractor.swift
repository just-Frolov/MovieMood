//
//  SplashScreenInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 30.04.2023.
//

import Foundation

protocol SplashScreenInteractor {
    func loadMovies() async throws -> MovieList
}

final class SplashScreenInteractorImpl {
    private weak var presenter: SplashScreenPresenter?
    private let network: Network
    
    //MARK: - Life Cycle -
    init(
        presenter: SplashScreenPresenterImpl,
        network: Network = ClNetwork()
    ) {
        self.presenter = presenter
        self.network = network
    }
}

extension SplashScreenInteractorImpl: SplashScreenInteractor {
    func loadMovies() async throws -> MovieList {
        let request = MovieListRequest()
        do {
            let movieList = try await network.request(endpoint: request)
            return movieList
        } catch let error {
            throw error
        }
    }
}
