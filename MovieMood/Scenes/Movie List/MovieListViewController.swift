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
        static let movieCardCellAspectRatio: CGFloat = 16.0 / 9.0
        static let movieCardCellContentInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
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
            tableView.backgroundColor = .clear
            tableView.dataSource = dataSource
            tableView.delegate = self
        }
    }
    
    //MARK: - Variables -
    private var dataSource: MovieListDataSource?
    private var movieCardCellHeight: CGFloat {
        let verticalInset = Constants.movieCardCellContentInsets.bottom + Constants.movieCardCellContentInsets.top
        let horisontalInset = Constants.movieCardCellContentInsets.left + Constants.movieCardCellContentInsets.right
        let cellWidth = tableView.bounds.width - horisontalInset
        return (cellWidth / Constants.movieCardCellAspectRatio) + verticalInset
    }

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
        dataSource = .init(
            tableView: tableView,
            cellContentInsets: Constants.movieCardCellContentInsets
        )
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return movieCardCellHeight
    }
}
