//
//  AssemblerBuilderProtocol.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createMovieListModule(router: AppRouter) -> UIViewController
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
    
    func createMovieListModule(router: AppRouter) -> UIViewController {
//        let view = MovieListViewController()
//        let presenter = MovieListPresenter(view: view,
//                                           router: router)
//        view.presenter = presenter
        return UIViewController()
    }
}

