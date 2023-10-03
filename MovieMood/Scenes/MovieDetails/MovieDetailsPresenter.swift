//
//  MovieDetailsPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.08.2023.
//

import UIKit

struct MovieDetailsConfiguration {
    let id: MovieId
    let title: String
}

enum MovieDetailsAction {
    case viewDidLoad
    case playback
}

protocol MovieDetailsPresenter: AnyObject {
    func inject(view: MovieDetailsView)
    func perform(action: MovieDetailsAction)
}

final class MovieDetailsPresenterImpl {

    // MARK: - Variables -
    private weak var view: MovieDetailsView?
    private var interactor: MovieDetailsInteractor
    private var router: AppRouter
    private var viewStateFactory: MovieDetailsViewStateFactory
    
    private var configuration: MovieDetailsConfiguration
    private var movieDetails: MovieDetails?
    private var videoList: [MovieVideo]?
    
    // MARK: - Life Cycle -
    init(
        router: AppRouter,
        interactor: MovieDetailsInteractor,
        viewStateFactory: MovieDetailsViewStateFactory,
        configuration: MovieDetailsConfiguration
    ) {
        self.router = router
        self.interactor = interactor
        self.viewStateFactory = viewStateFactory
        self.configuration = configuration
    }
}

extension MovieDetailsPresenterImpl: MovieDetailsPresenter {
    func inject(view: MovieDetailsView) {
        self.view = view
    }
    
    func perform(action: MovieDetailsAction) {
        switch action {
        case .viewDidLoad:
            performViewDidLoadAction()
        case .playback:
            performPlaybackAction()
        }
    }
}

private extension MovieDetailsPresenterImpl {
    func performViewDidLoadAction() {
        Task {
            let viewState = viewStateFactory.makeInitialViewState(configuration: configuration)
            await updateDataSource(viewState: viewState)
        }
       
        Task { await fetchMovieData() }
    }
    
    func performPlaybackAction() {
        guard let videoList else { return }
        Task { await router.showVideoPickerSheet(with: videoList) }
    }
}

private extension MovieDetailsPresenterImpl {
    @MainActor
    func updateView() async {
        guard let movieDetails else { return }
        let viewState = viewStateFactory.makeViewState(movieDetails: movieDetails, videoList: videoList)
        view?.render(with: viewState.title)
        await updateDataSource(viewState: viewState)
    }
    
    func updateDataSource(viewState: MovieDetailsViewState) async {
        var snapshot = NSDiffableDataSourceSnapshot<MovieDetailsDataSource.Section, AnyHashable>()
        
        if let mediaItems = viewState.mediaItems {
            snapshot.appendSections([.media])
            snapshot.appendItems(mediaItems, toSection: .media)
        }
        
        if let attributeItems = viewState.attributeItems {
            snapshot.appendSections([.attributes])
            snapshot.appendItems(attributeItems, toSection: .attributes)
        }
       
        await view?.setDataSource(snapshot: snapshot)
    }
    
    func fetchMovieData() async {
        async let movieDetailsTask = interactor.loadMovieDetails(by: configuration.id)
        async let videoListTask = interactor.loadMovieVideoList(by: configuration.id)
        
        do {
            movieDetails = try await movieDetailsTask
            videoList = try await videoListTask
        } catch let error {
            await view?.showAlert(
                title: Localized.errorTitle,
                message: error.localizedDescription
            ) {
                Task {
                    await self.router.popToRoot(animated: true)
                }
            }
        }
        
        await updateView()
    }
}


