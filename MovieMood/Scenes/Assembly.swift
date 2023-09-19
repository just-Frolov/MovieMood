//
//  Assembly.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol Assembly: AnyObject {
    func createMovieListModule() -> MovieListViewController
    func createMovieDetailsModule(configuration: MovieDetailsConfiguration) -> MovieDetailsViewController
    func createVideoPickerSheetModule(movieVideoList: [MovieVideo]) -> BottomSheetViewController
}

final class AssemblyImpl: Assembly {
    private let network: Network = ClNetwork()
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func createMovieListModule() -> MovieListViewController {
        let view = Storyboard.MovieList.movieListViewController.instantiate()
        let viewStateFactory = MovieListViewStateFactory()
        let interactor = MovieListInteractorImpl(network: network)
        let presenter = MovieListPresenterImpl(router: router, interactor: interactor, viewStateFactory: viewStateFactory)
        
        view.inject(presenter: presenter, alert: makeAlert(), loadingView: makeLoadingAnimation())
        presenter.inject(view: view)

        return view
    }
    
    func createMovieDetailsModule(configuration: MovieDetailsConfiguration) -> MovieDetailsViewController {
        let view = Storyboard.MovieDetails.movieDetailsViewController.instantiate()
        let viewStateFactory = MovieDetailsViewStateFactory()
        let interactor = MovieDetailsInteractorImpl(network: network)
        let presenter = MovieDetailsPresenterImpl(router: router, interactor: interactor, viewStateFactory: viewStateFactory, configuration: configuration)
        
        view.inject(presenter: presenter, alert: makeAlert(), loadingView: makeLoadingAnimation())
        presenter.inject(view: view)

        return view
    }
    
    func createVideoPickerSheetModule(movieVideoList: [MovieVideo]) -> BottomSheetViewController {
        let view = Storyboard.VideoPicker.videoPickerViewController.instantiate()
        let viewStateFactory = VideoPickerViewStateFactory()
        let presenter = VideoPickerPresenterImpl(
            viewStateFactory: viewStateFactory,
            movieVideoList: movieVideoList
        )
        
        view.inject(presenter: presenter)
        presenter.inject(view: view)

        let sheetView = Storyboard.BottomSheet.bottomSheetViewController.instantiate()
        sheetView.render(with: view)
        
        return sheetView
    }
}

private extension AssemblyImpl {
    func makeAlert() -> AlertPresentable {
        AlertController()
    }
    
    func makeLoadingAnimation() -> LoadingAnimationView {
        LoadingAnimationViewController()
    }
}

