//
//  HomeScreenView.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

@MainActor
protocol MovieListView: AnyObject {
    func render(with navigationBar: MovieListViewState.NavigationBar)
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<Int, AnyHashable>)
}

final class MovieListViewController: BaseViewController<MovieListPresenter> {
    
    private enum Constants {
        static let tableViewContentInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    static func instantiate(with presenter: MovieListPresenter) -> MovieListViewController {
        let viewController: MovieListViewController = Storyboard.MovieList.movieListViewController.instantiate()
        viewController.presenter = presenter
        return viewController
    }
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            MovieCardTableViewCell.xibRegister(in: tableView)
            tableView.contentInset = Constants.tableViewContentInsets
            tableView.backgroundColor = .clear
            tableView.dataSource = dataSource
            tableView.delegate = self
        }
    }
    
    //MARK: - Variables -
    private var dataSource: MovieListDataSource?

    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }
}

extension MovieListViewController: MovieListView {
    func render(with navigationBar: MovieListViewState.NavigationBar) {
        self.title = navigationBar.title
    }
    
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<Int, AnyHashable>) {
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

private extension MovieListViewController {
    func setupDataSource() {
        dataSource = .init(tableView: tableView)
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.fetchMoviesIfNeeded(indexPath: indexPath)
    }
}
