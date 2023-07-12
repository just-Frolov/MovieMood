//
//  MovieListDataSource.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit

final class MovieListDataSource: UITableViewDiffableDataSource<Int, AnyHashable> {
    init(tableView: UITableView, cellContentInsets: UIEdgeInsets) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            if let movieState = item as? MovieListViewState.MovieViewState {
                let cell = MovieCardTableViewCell
                    .dequeueingReusableCell(in: tableView, for: indexPath)
                cell.render(with: movieState, cellContentInsets)
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}
