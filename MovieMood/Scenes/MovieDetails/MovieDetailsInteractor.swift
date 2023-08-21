//
//  MovieDetailsInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.08.2023.
//

import Foundation

protocol MovieDetailsInteractor {
    func loadMovies(from page: Int, sortType: MovieListRequest.SortType) async throws -> MovieList
}

final class MovieDetailsInteractorImpl {
    private let network: Network
    
    //MARK: - Life Cycle -
    init(network: Network) {
        self.network = network
    }
}

extension MovieDetailsInteractorImpl: MovieDetailsInteractor {
    func loadMovies(from page: Int, sortType: MovieListRequest.SortType) async throws -> MovieList {
        let request = MovieListRequest(page: page, sortType: sortType)
        do {
            return try await network.request(endpoint: request)
        } catch let error {
            throw error
        }
    }
}
