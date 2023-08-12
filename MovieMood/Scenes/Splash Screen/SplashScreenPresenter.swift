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
    private var router: AppRouter?
        
    //MARK: - Life Cycle -
    init(router: AppRouter) {
        self.router = router
    }
    
    func inject(view: SplashScreenView) {
        self.view = view
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
        async let loadingAnimationTask = view?.showLoadingAnimation()
        //async let fetchingMoviesTask =
        
        await router?.popToRoot(animated: false)
    }
}
