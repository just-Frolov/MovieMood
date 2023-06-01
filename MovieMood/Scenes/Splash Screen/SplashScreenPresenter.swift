//
//  SplashScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import Foundation

protocol SplashScreenPresenter: AnyObject {
    func viewDidLoad()
}

final class SplashScreenPresenterImpl {

    //MARK: - Variables -
    private weak var view: SplashScreenView?
    private var interactor: SplashScreenInteractor?
    private var router: AppRouter?
        
    //MARK: - Life Cycle -
    init(router: AppRouter) {
        self.router = router
    }
    
    func inject(
        view: SplashScreenView,
        interactor: SplashScreenInteractor
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension SplashScreenPresenterImpl: SplashScreenPresenter {
    func viewDidLoad() {
        Task {
            await startInitialFlow()
        }
    }
}

private extension SplashScreenPresenterImpl {
    func startInitialFlow() async {
        let loadingAnimationTask = Task { await view?.showLoadingAnimation() }
        let fetchMoviesTask = Task { await fetchMovies() }
        
        await loadingAnimationTask.value
        if let fetchedMovies = await fetchMoviesTask.value {
            await router?.showHomeScreen(with: fetchedMovies)
        }
    }
    
    func fetchMovies() async -> MovieList? {
        do {
            guard let movies = try await interactor?.loadMovies() else {
                await showError(with: Localized.moviesLoadFailed)
                return nil
            }
            return movies
        } catch let error {
            await showError(with: error.localizedDescription)
            return nil
        }
    }
    
    func showError(with title: String) async {
        await MainActor.run(body: {
            view?.showError(message: title)
        })
    }
}
