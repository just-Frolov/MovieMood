//
//  VideoPickerDataSource.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import UIKit

final class VideoPickerDataSource: UITableViewDiffableDataSource<Int, AnyHashable> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            if let videoItem = item as? VideoItem {
                let cell = VideoPickerTableViewCell.dequeueingReusableCell(in: tableView, for: indexPath)
                cell.render(with: videoItem)
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}
