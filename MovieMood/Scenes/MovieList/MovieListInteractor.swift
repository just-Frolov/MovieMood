//
//  MovieListInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 13.07.2023.
//

import Foundation

protocol MovieListInteractor {
    func loadMovies(from page: Int, sortType: MovieListRequest.SortType) async throws -> MovieList
}

final class MovieListInteractorImpl {
    private let network: Network
    
    //MARK: - Life Cycle -
    init(network: Network) {
        self.network = network
    }
}

extension MovieListInteractorImpl: MovieListInteractor {
    func loadMovies(from page: Int, sortType: MovieListRequest.SortType) async throws -> MovieList {
        let request = MovieListRequest(page: page, sortType: sortType)
        do {
            let movieList = try await network.request(endpoint: request)
            return movieList
        } catch let error {
            throw error
        }
    }
}
