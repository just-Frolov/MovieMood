//
//  SceneDelegate.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
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
        let assemblyBuilder = AssemblerModuleBuilder()
        let router = AppRouterImpl(
            navigationController: navigationController,
            assemblyBuilder: assemblyBuilder
        )
        router.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
