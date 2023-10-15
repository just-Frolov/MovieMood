//
//  AppRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

protocol AppRouter {
    func inject(assembly: Assembly)
    func start()
}

final class AppRouterImpl {
    private let navigationController: UINavigationController
    private weak var assembly: Assembly!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AppRouterImpl: AppRouter {
    func inject(assembly: Assembly) {
        self.assembly = assembly
    }

    func start() {
        let homeViewController = assembly.createMovieListModule()
        navigationController.viewControllers = [homeViewController]
    }
}
