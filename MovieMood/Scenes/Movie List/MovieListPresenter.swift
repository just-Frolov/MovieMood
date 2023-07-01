//
//  HomeScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import Foundation

protocol MovieListPresenter: AnyObject {
    func viewDidLoad()
}

final class MovieListPresenterImpl {

    //MARK: - Variables -
    private weak var view: MovieListView?
    private var router: AppRouter?
    
    //MARK: - Life Cycle -
    init(router: AppRouter) {
        self.router = router
    }
    
    func inject(view: MovieListView) {
        self.view = view
    }
}

extension MovieListPresenterImpl: MovieListPresenter {
    func viewDidLoad() {
        //
    }
}

private extension MovieListPresenterImpl {

}

