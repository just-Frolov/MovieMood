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
        enum LoadingResult {
            case movieList([Movie])
            case void
        }
        
        let movieList = await withThrowingTaskGroup(of: LoadingResult.self) { taskGroup -> [Movie] in
            taskGroup.addTask {
                await self.view?.showLoadingAnimation()
                return .void
            }
            taskGroup.addTask {
                let movieList = await self.fetchMovies()
                return .movieList(movieList)
            }

            var movieList: [Movie] = []

            do {
                for try await value in taskGroup {
                    switch value {
                    case .movieList(let movies):
                        movieList = movies
                    default:
                        continue
                    }
                }
            } catch {
                debugPrint("Fetch movies at least partially failed: \(error.localizedDescription)")
            }
            
            return movieList
        }
        
        await router?.showHomeScreen(with: movieList)
    }
    
    func fetchMovies() async -> [Movie] {
        do {
            guard let fetchedMovies = try await interactor?.loadMovies() else {
                await showError(with: Localized.moviesLoadFailed)
                return []
            }
            return fetchedMovies.results
        } catch let error {
            await showError(with: error.localizedDescription)
            return []
        }
    }
    
    func showError(with title: String) async {
        await view?.showError(message: title)
    }
}
