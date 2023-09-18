//
//  AppRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import UIKit

@MainActor
protocol AppRouter {
    func inject(assemblyBuilder: AssemblyProtocol)
    func start()
    
    func popToRoot(animated: Bool)
    func showMovieDetails(with configuration: MovieDetailsConfiguration)
    func showVideoPickerSheet(with videoList: [MovieVideo])
}

final class AppRouterImpl {
    private let navigationController: UINavigationController
    private weak var assemblyBuilder: AssemblyProtocol!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AppRouterImpl: AppRouter {
    
    func inject(assemblyBuilder: AssemblyProtocol) {
        self.assemblyBuilder = assemblyBuilder
    }

    func start() {
        let homeViewController = assemblyBuilder.createMovieListModule()
        
        navigationController.viewControllers = [homeViewController]
    }
 
    func showMovieDetails(with configuration: MovieDetailsConfiguration) {
        let movieDetailsViewController = assemblyBuilder.createMovieDetailsModule(configuration: configuration)
        
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func showVideoPickerSheet(with videoList: [MovieVideo]) {
        let videoPickerViewController = assemblyBuilder.createVideoPickerSheetModule(movieVideoList: videoList)
        videoPickerViewController.modalPresentationStyle = .overFullScreen
        videoPickerViewController.modalTransitionStyle = .crossDissolve
        
        navigationController.present(videoPickerViewController, animated: true)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
}
