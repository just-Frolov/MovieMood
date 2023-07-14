//
//  HomeScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

protocol MovieListPresenter: AnyObject {
    func viewDidLoad()
    func fetchMoviesIfNeeded(indexPath: IndexPath)
}

final class MovieListPresenterImpl {

    private enum Constants {
        static let cellsUntilPaginationLimit = 5
    }
    
    //MARK: - Variables -
    private weak var view: MovieListView?
    private var interactor: MovieListInteractor?
    private var router: AppRouter?
    private var viewStateFactory: MovieListViewStateFactory
    
    private var movieList: [Movie] = []
    private var isMoviesLoading = false
    private var currentPage: Int? = 1 //TODO: move to dataSource?
    
    //MARK: - Life Cycle -
    init(
        router: AppRouter,
        viewStateFactory: MovieListViewStateFactory
    ) {
        self.router = router
        self.viewStateFactory = viewStateFactory
    }
    
    func inject(
        view: MovieListView,
        interactor: MovieListInteractor,
        movieList: [Movie]
    ) {
        self.view = view
        self.interactor = interactor
        self.movieList = movieList
    }
}

extension MovieListPresenterImpl: MovieListPresenter {
    func viewDidLoad() {
        Task {
            await updateView()
        }
    }
    
    func fetchMoviesIfNeeded(indexPath: IndexPath) {
        if movieList.count - Constants.cellsUntilPaginationLimit == indexPath.row, !isMoviesLoading {
            Task { await fetchMovies() }
        }
    }
}

private extension MovieListPresenterImpl {
    @MainActor
    func updateView() async {
        let viewState = viewStateFactory.makeViewState(movieList: movieList)
        view?.render(with: viewState.navigationBar)
        await updateDataSource(items: viewState.items)
    }
    
    func updateDataSource(items: [MovieListViewState.Item]) async {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        await view?.setDataSource(snapshot: snapshot)
    }
    
    func fetchMovies() async {
        guard var currentPage else { return }
        isMoviesLoading = true
        currentPage += 1
        self.currentPage = currentPage
        
        do {
            guard
                let additionalMovies = try await interactor?.loadMovies(from: currentPage).results
            else {
                handleError()
                return
            }
            
            isMoviesLoading = false
            self.movieList.append(contentsOf: additionalMovies)
        
            Task { await self.updateView() }
        } catch let error {
            handleError(error)
        }
    }
    
    func handleError(_ error: Error? = nil) {
        if let error {
            debugPrint(error)
        }
        
        currentPage = nil
        isMoviesLoading = false
    }
}

