//
//  MovieDetailsInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.08.2023.
//

import Foundation

protocol MovieDetailsInteractor {
    func loadMovieDetails(by id: MovieId) async throws -> MovieDetails
    func loadMovieVideoList(by id: MovieId) async throws -> [MovieVideo]
}

final class MovieDetailsInteractorImpl {
    private let network: Network
    
    //MARK: - Life Cycle -
    init(network: Network) {
        self.network = network
    }
}

extension MovieDetailsInteractorImpl: MovieDetailsInteractor {
    func loadMovieDetails(by id: MovieId) async throws -> MovieDetails {
        let path: ClNetwork.EndpointPath = .movieDetails(id)
        let request = MovieDetailsRequest(path: path)
        do {
            return try await network.request(endpoint: request)
        } catch let error {
            throw error
        }
    }
    
    func loadMovieVideoList(by id: MovieId) async throws -> [MovieVideo] {
        let path: ClNetwork.EndpointPath = .movieVideoList(id)
        let request = MovieVideoListRequest(path: path)
        do {
            return try await network.request(endpoint: request).results
        } catch let error {
            throw error
        }
    }
}
