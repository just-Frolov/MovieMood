//
//  MovieListInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 13.07.2023.
//

import Foundation

protocol MovieListInteractor {
    func loadMovies(sortType: MovieListSortType, from page: Int) async throws -> MoviesResponse
    func searchMovies(query: String, from page: Int) async throws -> MoviesResponse
}

final class MovieListInteractorImpl {
    private let network: Network
    
    // MARK: - Life Cycle -
    init(network: Network) {
        self.network = network
    }
}

extension MovieListInteractorImpl: MovieListInteractor {
    func loadMovies(sortType: MovieListSortType, from page: Int) async throws -> MoviesResponse {
        let path = ClNetwork.EndpointPath.movieList(sortType: sortType, page: page)
        let request = MovieListRequest(path: path)
        do {
            let movieList = try await network.request(endpoint: request)
            return movieList
        } catch let error {
            throw error
        }
    }
    
    func searchMovies(query: String, from page: Int) async throws -> MoviesResponse {
        let path = ClNetwork.EndpointPath.movieSearch(query: query, page: page)
        let request = MovieSearchRequest(path: path)
        do {
            let movieList = try await network.request(endpoint: request)
            return movieList
        } catch let error {
            throw error
        }
    }
}
