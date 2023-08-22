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
    func didSelect(item: MovieListViewState.Item)
}

final class MovieListPresenterImpl {

    private enum Constants {
        static let cellsUntilPaginationLimit = 5
    }
    
    //MARK: - Variables -
    private weak var view: MovieListView?
    private var interactor: MovieListInteractor
    private var router: AppRouter
    private var viewStateFactory: MovieListViewStateFactory
    
    private var movieList: [Movie] = []
    private var isMoviesLoading = false
    private var currentPage: Int = 1
    private var canLoadNextPage: Bool = true
    
    //MARK: - Life Cycle -
    init(
        router: AppRouter,
        interactor: MovieListInteractor,
        viewStateFactory: MovieListViewStateFactory
    ) {
        self.router = router
        self.interactor = interactor
        self.viewStateFactory = viewStateFactory
    }
    
    func inject(view: MovieListView) {
        self.view = view
    }
}

extension MovieListPresenterImpl: MovieListPresenter {
    func viewDidLoad() {
        Task {
            await view?.showLoadingIndicator()
            await view?.hideLoadingIndicator()
        }
        
        Task {
            await updateView()
            await fetchMovies()
        }
    }

    func fetchMoviesIfNeeded(indexPath: IndexPath) {
        if movieList.count - Constants.cellsUntilPaginationLimit == indexPath.row && !isMoviesLoading && canLoadNextPage {
            Task { await fetchMovies() }
        }
    }
    
    @MainActor
    func didSelect(item: MovieListViewState.Item) {
        let movieDetailsConfiguration = MovieDetailsConfiguration(id: item.id, title: item.title)
        router.showMovieDetails(with: movieDetailsConfiguration)
    }
}

private extension MovieListPresenterImpl {
    @MainActor
    func updateView() async {
        guard let view else { return }
        let viewState = viewStateFactory.makeViewState(movieList: movieList)
        view.render(with: viewState.navigationBar)
        await updateDataSource(items: viewState.items)
    }
    
    func updateDataSource(items: [MovieListViewState.Item]) async {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)

        await view?.setDataSource(snapshot: snapshot)
    }
    
    func fetchMovies() async {
        isMoviesLoading = true

        do {
            let additionalMovies = try await interactor.loadMovies(
                from: currentPage,
                sortType: .popularity
            ).results
            
            currentPage += 1
            isMoviesLoading = false
            self.movieList.append(contentsOf: additionalMovies)
            
            Task { await self.updateView() }
        } catch let error {
            debugPrint(error)
            
            canLoadNextPage = false
            isMoviesLoading = false
        }
    }
}

