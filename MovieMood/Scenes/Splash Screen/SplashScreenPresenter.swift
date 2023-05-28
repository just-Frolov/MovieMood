//
//  SplashScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import Foundation

protocol SplashScreenPresenter {
    func didFetchMovies(with result: Result<[MovieList], Error>)
}

final class SplashScreenPresenterImpl {

    //MARK: - Variables -
    private weak var view: SplashScreenViewController?
    private var interactor: SplashScreenInteractorImpl? {
        didSet {
            fetchMovies()
        }
    }
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
    func didFetchMovies(with result: Result<[MovieList], Error>) {
        //
    }
}

private extension SplashScreenPresenterImpl {
    func fetchMovies() {
        print(interactor)
        Task {
            print(interactor)
            await interactor?.loadMovies()
        }
    }
}
