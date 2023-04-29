//
//  SplashScreenCoordinator.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

final class SplashScreenCoordinator: BaseCoordinator<Void> {
    
    // MARK: - Init
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let controller = SplashScreenViewController()
        let presenter = SplashScreenPresenterImpl(view: controller)
        controller.presenter = presenter
        navigationController.setViewControllers([controller], animated: false)
    }
}
