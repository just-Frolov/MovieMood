//
//  SplashScreenInteractor.swift
//  MovieMood
//
//  Created by Danil Frolov on 30.04.2023.
//

import Foundation

protocol SplashScreenInteractor {
    func getMovies()
}

final class SplashScreenInteractorImpl {
    private weak var presenter: SplashScreenPresenterImpl?

    //MARK: - Life Cycle -
    init(presenter: SplashScreenPresenterImpl) {
        self.presenter = presenter
    }
}

extension SplashScreenInteractorImpl {
    func getMovies() {
        
    }
}
