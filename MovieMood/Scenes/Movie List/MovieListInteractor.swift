//
//  MovieListInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 13.07.2023.
//

import Foundation

protocol MovieListInteractor {
    func loadMovies(from page: Int) async throws -> MovieList
}

final class MovieListInteractorImpl {
    private weak var presenter: MovieListPresenter?
    private let network: Network
    
    //MARK: - Life Cycle -
    init(
        presenter: MovieListPresenter,
        network: Network = ClNetwork()
    ) {
        self.presenter = presenter
        self.network = network
    }
}

extension MovieListInteractorImpl: MovieListInteractor {
    func loadMovies(from page: Int) async throws -> MovieList {
        let request = MovieListRequest(page: page)
        do {
            let movieList = try await network.request(endpoint: request)
            return movieList
        } catch let error {
            throw error
        }
    }
}
