//
//  AssemblerModuleBuilder.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol AssemblerProtocol {
    func createMovieListModule(router: AppRouter) -> MovieListViewController
}

//TODO: for tests I will use dependencyInjection to be able to change entities to fakes
final class Assembler: AssemblerProtocol {
    let network: Network = ClNetwork()
    
    func createMovieListModule(router: AppRouter) -> MovieListViewController {
        let view = Storyboard.MovieList.movieListViewController.instantiate()
        let viewStateFactory = MovieListViewStateFactory()
        let presenter = MovieListPresenterImpl(router: router, viewStateFactory: viewStateFactory)
        let interactor = MovieListInteractorImpl(presenter: presenter, network: network)
        
        view.presenter = presenter
        view.alert = makeAlert()
        
        presenter.inject(view: view, interactor: interactor)

        return view
    }
}

private extension Assembler {
    func makeAlert() -> UIAlertController {
        return UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }
    
//    func makeLoadingAnimation() -> SplashScreenViewController {
//        let presenter = SplashScreenPresenterImpl(router: router)
//        let view = SplashScreenViewController.instantiate(with: presenter, alert: makeAlert())
//
//        presenter.inject(view: view)
//
//        return view
//    }
}

