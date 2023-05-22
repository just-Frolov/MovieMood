//
//  SplashScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import Foundation

protocol SplashScreenPresenter {
    func didFetchMovies(with: MovieResponce)
}

final class SplashScreenPresenterImpl {

    //MARK: - Variables -
    private weak var view: SplashScreenViewController?
    private weak var interactor: SplashScreenInteractorImpl?
    private var router: AppRouter?
    
    //MARK: - Life Cycle -
    init(router: AppRouter) {
        self.router = router
    }
    
    func configure(
        view: SplashScreenViewController,
        interactor: SplashScreenInteractorImpl
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension SplashScreenPresenterImpl: SplashScreenPresenter {
    func didFetchMovies(with: MovieResponce) {
        //
    }
}
