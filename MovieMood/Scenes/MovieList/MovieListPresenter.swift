//
//  HomeScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

enum MovieListSortType: String {
    case popularity = "popularity.desc"
    case vote = "vote_average"
}

enum MovieListAction {
    case viewDidLoad
    case scroll(indexPath: IndexPath)
    case select(item: MovieListItem)
    case search(query: String?, forceUpdate: Bool)
}

protocol MovieListPresenter: AnyObject {
    func inject(view: MovieListView)
    func perform(action: MovieListAction)
}

final class MovieListPresenterImpl {

    private enum Constant {
        static let initialFetchPage = 1
        static let cellsUntilPaginationLimit = 5
        static let searchDelay = 500
        static let itemsPerPage = 20
    }
    
    // MARK: - Variables -
    private weak var view: MovieListView?
    private var interactor: MovieListInteractor
    private var router: AppRouter
    private var viewStateFactory: MovieListViewStateFactory
    
    private var movieList: [Movie] = []
    private var currentPage: Int {
        get {
            movieList.count / Constant.itemsPerPage + Constant.initialFetchPage
        }
    }
    private var isMoviesLoading = false
    private var canLoadNextPage: Bool {
        get {
            movieList.count % Constant.itemsPerPage == .zero
        }
    }
    
    private var searchText: String?
    private var searchWorkItem: DispatchWorkItem?
    
    // MARK: - Life Cycle -
    init(
        router: AppRouter,
        interactor: MovieListInteractor,
        viewStateFactory: MovieListViewStateFactory
    ) {
        self.router = router
        self.interactor = interactor
        self.viewStateFactory = viewStateFactory
    }
}

extension MovieListPresenterImpl: MovieListPresenter {
    func inject(view: MovieListView) {
        self.view = view
    }
    
    func perform(action: MovieListAction) {
        switch action {
        case .viewDidLoad:
            performViewDidLoadAction()
        case .scroll(let indexPath):
            performScrollAction(with: indexPath)
        case .select(let item):
            performSelectAction(for: item)
        case .search(let query, let forceUpdate):
            performSearchAction(with: query, forceUpdate: forceUpdate)
        }
    }
}

private extension MovieListPresenterImpl {
    func performViewDidLoadAction() {
        Task {
            await view?.showLoadingIndicator()
            await view?.hideLoadingIndicator()
        }
        
        Task {
            await updateView()
            await fetchMovies()
        }
    }

    func performScrollAction(with indexPath: IndexPath) {
        guard movieList.count - Constant.cellsUntilPaginationLimit == indexPath.row && !isMoviesLoading && canLoadNextPage else {
            return
        }
        
        if let searchText {
            Task { await searchMovies(query: searchText, isNewSearch: false) }
        } else {
            Task { await fetchMovies() }
        }
    }
    
    func performSelectAction(for item: MovieListItem) {
        Task {
            let movieDetailsConfiguration = MovieDetailsConfiguration(id: item.id, title: item.title)
            await router.showMovieDetails(with: movieDetailsConfiguration)
        }
    }
    
    func performSearchAction(with query: String?, forceUpdate: Bool) {
        searchWorkItem?.cancel()
        
        guard let query, !query.isEmpty else {
            if searchText != nil {
                searchText = nil
                movieList = []
                Task { await fetchMovies() }
            }
            return
        }
        
        guard !forceUpdate else {
            Task { await searchMovies(query: query, isNewSearch: true) }
            return
        }
        
        let delay = query.isEmpty ? .zero : Constant.searchDelay
        let newWorkItem = DispatchWorkItem { [unowned self] in
            Task { await searchMovies(query: query, isNewSearch: true) }
        }
        
        searchWorkItem = newWorkItem
        DispatchQueue.global().asyncAfter(
            deadline: .now() + .milliseconds(delay),
            execute: newWorkItem
        )
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
    
    func updateDataSource(items: [MovieListItem]) async {
        guard items.count <= Constant.itemsPerPage else {
            await view?.append(items: items)
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(items, toSection: .zero)

        await view?.setDataSource(snapshot: snapshot)
    }
    
    func fetchMovies() async {
        isMoviesLoading = true

        do {
            let additionalMovies = try await interactor.loadMovies(
                sortType: .popularity,
                from: currentPage
            ).results
            
            isMoviesLoading = false
           
            movieList.append(contentsOf: additionalMovies)
            Task { await self.updateView() }
        } catch let error {
            debugPrint(error)
            
            isMoviesLoading = false
        }
    }
    
    func searchMovies(query: String, isNewSearch: Bool) async {
        isMoviesLoading = true
        
        if isNewSearch {
            movieList = []
            searchText = query
        }
        
        do {
            let additionalMovies = try await interactor.searchMovies(
                query: query,
                from: currentPage
            ).results
            isMoviesLoading = false
            movieList.append(contentsOf: additionalMovies)
                        
            Task { await self.updateView() }
        } catch let error {
            debugPrint(error)
            
            isMoviesLoading = false
        }
    }
}

