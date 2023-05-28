//
//  SplashScreenInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 30.04.2023.
//

import Foundation

protocol SplashScreenInteractor {
    func loadMovies()
}

final class SplashScreenInteractorImpl {
    private weak var presenter: SplashScreenPresenterImpl?
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

extension SplashScreenInteractorImpl {
    func loadMovies() async {
        let request = MovieListRequest()
        do {
            let movieList = try await network.request(endpoint: request)
           
            await MainActor.run {
                presenter?.didFetchMovies(with: .success(movieList))
            }
        } catch let error {
            await MainActor.run {
                presenter?.didFetchMovies(with: .failure(error))
            }
        }
    }
}
