//
//  AssemblerBuilderProtocol.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createHomeModule(movieList: [Movie], router: AppRouter) -> UIViewController
    func createLaunchScreenModule(router: AppRouter) -> UIViewController
}

final class AssemblerModuleBuilder: AssemblerBuilderProtocol {
    func createLaunchScreenModule(router: AppRouter) -> UIViewController {
        let presenter = SplashScreenPresenterImpl(router: router)
        let interactor = SplashScreenInteractorImpl(presenter: presenter)
        let view = SplashScreenViewController.instantiate(with: presenter)
        
        presenter.inject(view: view, interactor: interactor)
        
        return view
    }
    
    func createHomeModule(movieList: [Movie], router: AppRouter) -> UIViewController {
        let presenter = MovieListPresenterImpl(router: router, movieList: movieList)
        let interactor = MovieListInteractorImpl(presenter: presenter)
        let view = MovieListViewController.instantiate(with: presenter)
        
        presenter.inject(view: view, interactor: interactor)

        return view
    }
}

