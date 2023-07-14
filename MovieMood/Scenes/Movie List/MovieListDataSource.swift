//
//  MovieListDataSource.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit

final class MovieListDataSource: UITableViewDiffableDataSource<Int, AnyHashable> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            if let movieState = item as? MovieListViewState.Item {
                let cell = MovieCardTableViewCell
                    .dequeueingReusableCell(in: tableView, for: indexPath)
                cell.render(with: movieState)
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}
