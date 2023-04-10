//
//  SplashScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import Foundation

protocol SplashScreenPresenter: AnyObject {
    func onAppear()
}

final class SplashScreenPresenterImpl {
    
    private weak var view: SplashScreenView?

    init(view: SplashScreenView) {
        self.view = view
    }
}

extension SplashScreenPresenterImpl: SplashScreenPresenter {
    func onAppear() {

    }
}
