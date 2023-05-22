//
//  AppRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

protocol AppRouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblerBuilderProtocol? { get set }
}

protocol AppRouter: AppRouterMain {
    func showMovieList()
    func popToRoot()
}

final class AppRouterImpl: AppRouter {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblerBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func start() {
        guard
            let viewController = assemblyBuilder?
                .createLaunchScreenModule(router: self) else {
            return
        }
        navigationController?.viewControllers = [viewController]
    }
    
    func showMovieList() {
        guard let viewController = assemblyBuilder?.createMovieListModule(router: self) else { return }
        navigationController?.viewControllers = [viewController]
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
