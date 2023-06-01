//
//  HomeScreenPresenter.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import Foundation

protocol HomeScreenPresenter: AnyObject {
    func viewDidLoad()
}

final class HomeScreenPresenterImpl {

    //MARK: - Variables -
    private weak var view: HomeScreenView?
    private var router: AppRouter?
    
    //MARK: - Life Cycle -
    init(router: AppRouter) {
        self.router = router
    }
    
    func inject(view: HomeScreenView) {
        self.view = view
    }
}

extension HomeScreenPresenterImpl: HomeScreenPresenter {
    func viewDidLoad() {
        //
    }
}

private extension HomeScreenPresenterImpl {

}

