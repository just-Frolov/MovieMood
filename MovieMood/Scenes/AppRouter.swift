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
    func showMovieDetails(with configuration: MovieDetailsConfiguration)
    func showVideoPickerSheet(with videoList: [MovieVideo])
}

final class AppRouterImpl {
    private let navigationController: UINavigationController
    private weak var assembly: Assembly!
    
    // MARK: - Init -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal -
    func inject(assembly: Assembly) {
        self.assembly = assembly
    }

    func start() {
        let homeViewController = assembly.createMovieListModule()
        navigationController.viewControllers = [homeViewController]
    }
}

extension AppRouterImpl: AppRouter {
    func showMovieDetails(with configuration: MovieDetailsConfiguration) {
        let movieDetailsViewController = assembly.createMovieDetailsModule(configuration: configuration)
        
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func showVideoPickerSheet(with videoList: [MovieVideo]) {
        let videoPickerViewController = assembly.createVideoPickerSheetModule(movieVideoList: videoList)
        videoPickerViewController.modalPresentationStyle = .overFullScreen
        // keep false
        // modal animation will be handled in VC itself
        navigationController.present(videoPickerViewController, animated: false)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
}
