//
//  SceneDelegate.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var assembly: Assembly?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let scene = scene as? UIWindowScene {
            createWindowScene(scene)
        }
    }
}

private extension SceneDelegate {
    func createWindowScene(_ windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let navigationController = UINavigationController()
        let router = AppRouterImpl(navigationController: navigationController)
        let assembly = AssemblyImpl()
        self.assembly = assembly

        router.inject(assembly: assembly)
        router.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
