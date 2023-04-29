//
//  RootCoordinator.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

final class RootCoordinator: BaseCoordinator<Void> {
    
    private unowned let window: UIWindow
    private let navigationController = UINavigationController()
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        let coordinator = SplashScreenCoordinator(
            navigationController: navigationController
        )

        coordinate(to: coordinator)
    }
}
