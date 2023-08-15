//
//  AppRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

@MainActor
protocol AppRouter {
    func popToRoot(animated: Bool)
    func showMovieDetails(with id: MovideId)
}

final class AppRouterImpl: AppRouter {
    let navigationController: UINavigationController
    let assemblyBuilder: AssemblerProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func start() {
        let homeViewController = assemblyBuilder.createMovieListModule(router: self)
        
        navigationController.viewControllers = [homeViewController]
    }
 
    func showMovieDetails(with id: MovideId) {
        // TO DO
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
}
