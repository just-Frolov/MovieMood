//
//  MovieDetailsPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.08.2023.
//

import UIKit

protocol MovieDetailsPresenter: AnyObject {
    func viewDidLoad()
}

final class MovieDetailsPresenterImpl {

    private enum Constants {
        static let cellsUntilPaginationLimit = 5
    }
    
    //MARK: - Variables -
    private weak var view: MovieDetailsView?
    private var interactor: MovieDetailsInteractor?
    private var router: AppRouter
    private var viewStateFactory: MovieDetailsViewStateFactory
    
    private var movieItem: MovieListViewState.Item
    
    //MARK: - Life Cycle -
    init(
        router: AppRouter,
        viewStateFactory: MovieDetailsViewStateFactory,
        movieItem: MovieListViewState.Item
    ) {
        self.router = router
        self.viewStateFactory = viewStateFactory
        self.movieItem = movieItem
    }
    
    func inject(
        view: MovieDetailsView,
        interactor: MovieDetailsInteractor
    ) {
        self.view = view
        self.interactor = interactor
    }    
}

extension MovieDetailsPresenterImpl: MovieDetailsPresenter {
    func viewDidLoad() {
        Task { await view?.render(with: movieItem.title) }
        Task { await fetchMovieDetails() }
    }
}

private extension MovieDetailsPresenterImpl {
    @MainActor
    func updateView() async {
        guard let view else { return }
        //let viewState = viewStateFactory.makeViewState(movieList: movieList)
        //await updateDataSource(items: viewState.items)
    }
    
    func updateDataSource(items: [MovieListViewState.Item]) async {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        await view?.setDataSource(snapshot: snapshot)
    }
    
    func fetchMovieDetails() async {

//        do {
//            guard
//                let additionalMovies = try await interactor?.loadMovies(from: currentPage, sortType: .popularity).results
//            else {
//                handleError()
//                return
//            }
//
//            self.movieList.append(contentsOf: additionalMovies)
//
//            Task { await self.updateView() }
//        } catch let error {
//            handleError(error)
//        }
    }
}


