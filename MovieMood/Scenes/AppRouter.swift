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
    func showVideoPicker(with videoList: [MovieVideo])
    func showBottomSheet()
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
        let homeViewController = assemblyBuilder.createMovieListModule(router: self)
        
        navigationController.viewControllers = [homeViewController]
    }
 
    func showMovieDetails(with configuration: MovieDetailsConfiguration) {
        let movieDetailsViewController = assemblyBuilder.createMovieDetailsModule(router: self, configuration: configuration)
        
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func showVideoPicker(with videoList: [MovieVideo]) {
        let videoPickerViewController = assemblyBuilder.createVideoPickerModule(movieVideoList: videoList)
        videoPickerViewController.modalPresentationStyle = .overFullScreen
        videoPickerViewController.modalTransitionStyle = .crossDissolve
        
        navigationController.present(videoPickerViewController, animated: true)
    }
    
    func showBottomSheet() {
//        let bottomSheet = assemblyBuilder.createVideoPickerModule(movieVideoList: <#T##[MovieVideo]#>)
//        bottomSheet.modalPresentationStyle = .overFullScreen
        // keep false
        // modal animation will be handled in VC itself
        //navigationController.present(bottomSheet, animated: false)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
}
