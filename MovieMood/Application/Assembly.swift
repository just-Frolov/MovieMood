//
//  Assembly.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

protocol Assembly: AnyObject {
    func createMovieListModule() -> MovieListView
    func createMovieDetailsModule(configuration: MovieDetailsConfiguration) -> MovieDetailsView
    func createVideoPickerSheetModule(movieVideoList: [MovieVideo]) -> BottomSheetView
}

final class AssemblyImpl {
    private let network: Network = ClNetwork()
}

extension AssemblyImpl: Assembly {
    func createMovieListModule() -> MovieListView {
        let view: MovieListView = Storyboard.MovieList.movieListViewController.instantiate()
        let viewStateFactory = MovieListViewStateFactory()
        let interactor = MovieListInteractorImpl(network: network)
        let router: MovieListRouter = MovieListRouterImpl()
        let presenter: MovieListPresenter = MovieListPresenterImpl(
            router: router,
            interactor: interactor,
            viewStateFactory: viewStateFactory
        )
        
        view.inject(
            presenter: presenter,
            alert: makeAlert(),
            loadingView: makeLoadingAnimation()
        )
        presenter.inject(view: view)
        router.inject(root: view, assembly: self)

        return view
    }
    
    func createMovieDetailsModule(configuration: MovieDetailsConfiguration) -> MovieDetailsView {
        let view: MovieDetailsView = Storyboard.MovieDetails.movieDetailsViewController.instantiate()
        let viewStateFactory = MovieDetailsViewStateFactory()
        let interactor = MovieDetailsInteractorImpl(network: network)
        let router: MovieDetailsRouter = MovieDetailsRouterImpl()
        let presenter: MovieDetailsPresenter = MovieDetailsPresenterImpl(
            router: router,
            interactor: interactor,
            viewStateFactory: viewStateFactory,
            configuration: configuration
        )
        
        view.inject(
            presenter: presenter,
            alert: makeAlert(),
            loadingView: makeLoadingAnimation()
        )
        presenter.inject(view: view)
        router.inject(root: view, assembly: self)

        return view
    }
    
    func createVideoPickerSheetModule(movieVideoList: [MovieVideo]) -> BottomSheetView {
        let view: VideoPickerView = Storyboard.VideoPicker.videoPickerViewController.instantiate()
        let viewStateFactory = VideoPickerViewStateFactory()
        let presenter: VideoPickerPresenter = VideoPickerPresenterImpl(
            viewStateFactory: viewStateFactory,
            movieVideoList: movieVideoList
        )
        
        view.inject(presenter: presenter)
        presenter.inject(view: view)

        let sheetView: BottomSheetView = Storyboard.BottomSheet.bottomSheetViewController.instantiate()
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

