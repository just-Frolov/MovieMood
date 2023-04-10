//
//  SceneDelegate.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var rootCoordinator: RootCoordinator!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            self.window = window
            rootCoordinator = RootCoordinator(window: window)
            rootCoordinator.start()
        }
    }
}
