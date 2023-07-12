//
//  HomeScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

protocol MovieListPresenter: AnyObject {
    func viewDidLoad()
}

final class MovieListPresenterImpl {

    //MARK: - Variables -
    private weak var view: MovieListView?
    private var router: AppRouter?
    private var viewState: MovieListViewState
    
    //MARK: - Life Cycle -
    init(router: AppRouter, movieList: [Movie]) {
        self.router = router
        viewState = MovieListViewState.makeViewState(movieList: movieList)
    }
    
    func inject(view: MovieListView) {
        self.view = view
    }
}

extension MovieListPresenterImpl: MovieListPresenter {
    func viewDidLoad() {
        Task {
            await updateView()
        }
    }
}

private extension MovieListPresenterImpl {
    @MainActor
    func updateView() async {
        view?.render(with: self.viewState.navigationBar)
        await updateDataSource()
    }
    
    func updateDataSource() async {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewState.movies, toSection: 0)

        await view?.setDataSource(snapshot: snapshot)
    }
}

