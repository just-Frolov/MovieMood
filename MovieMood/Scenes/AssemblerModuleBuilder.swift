//
//  AssemblerModuleBuilder.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createLaunchScreenModule(router: AppRouter) -> SplashScreenViewController
    func createHomeModule(movieList: [Movie], router: AppRouter) -> MovieListViewController
}

//TODO: for tests I will use dependencyInjection to be able to change entities to fakes
final class AssemblerModuleBuilder: AssemblerBuilderProtocol {
    func createLaunchScreenModule(router: AppRouter) -> SplashScreenViewController {
        let presenter = SplashScreenPresenterImpl(router: router)
        let interactor = SplashScreenInteractorImpl(presenter: presenter)
        let view = SplashScreenViewController.instantiate(with: presenter)
        
        presenter.inject(view: view, interactor: interactor)
        
        return view
    }
    
    func createHomeModule(movieList: [Movie], router: AppRouter) -> MovieListViewController {
        let viewStateFactory = MovieListViewStateFactory()
        let presenter = MovieListPresenterImpl(router: router, viewStateFactory: viewStateFactory)
        let interactor = MovieListInteractorImpl(presenter: presenter)
        let view = MovieListViewController.instantiate(with: presenter)
        
        presenter.inject(view: view, interactor: interactor, movieList: movieList)

        return view
    }
}

