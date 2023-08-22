//
//  AssemblerModuleBuilder.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol AssemblerProtocol {
    func createMovieListModule(router: AppRouter) -> MovieListViewController
    func createMovieDetailsModule(router: AppRouter, configuration: MovieDetailsConfiguration) -> MovieDetailsViewController
}

//TODO: for tests I will use dependencyInjection to be able to change entities to fakes
final class Assembler: AssemblerProtocol {
    let network: Network = ClNetwork()
    
    func createMovieListModule(router: AppRouter) -> MovieListViewController {
        let view = Storyboard.MovieList.movieListViewController.instantiate()
        let viewStateFactory = MovieListViewStateFactory()
        let interactor = MovieListInteractorImpl(network: network)
        let presenter = MovieListPresenterImpl(router: router, interactor: interactor, viewStateFactory: viewStateFactory)
        
        view.inject(presenter: presenter, alert: makeAlert(), loadingView: makeLoadingAnimation())
        presenter.inject(view: view)

        return view
    }
    
    func createMovieDetailsModule(
        router: AppRouter,
        configuration: MovieDetailsConfiguration
    ) -> MovieDetailsViewController {
        let view = Storyboard.MovieDetails.movieDetailsViewController.instantiate()
        let viewStateFactory = MovieDetailsViewStateFactory()
        let interactor = MovieDetailsInteractorImpl(network: network)
        let presenter = MovieDetailsPresenterImpl(router: router, interactor: interactor, viewStateFactory: viewStateFactory, configuration: configuration)
        
        view.inject(presenter: presenter, alert: makeAlert(), loadingView: makeLoadingAnimation())
        presenter.inject(view: view)

        return view
    }
}

private extension Assembler {
    func makeAlert() -> UIAlertController {
        UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }
    
    func makeLoadingAnimation() -> LoadingAnimationView {
        LoadingAnimationViewController()
    }
}

