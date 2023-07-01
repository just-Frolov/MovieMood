//
//  HomeScreenView.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

@MainActor
protocol MovieListView: AnyObject {
    
}

final class MovieListViewController: BaseViewController<MovieListPresenter> {
    
    private enum Constants {

    }
    
    static func instantiate(with presenter: MovieListPresenter) -> MovieListViewController {
        let viewController: MovieListViewController = Storyboard.MovieList.movieListViewController.instantiate()
        viewController.presenter = presenter
        return viewController
    }
  
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MovieListViewController: MovieListView {

}

private extension MovieListViewController {
 
}

