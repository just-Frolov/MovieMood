//
//  TableCellReusable.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit

protocol TableCellReusable: UITableViewCell {
   
}

extension TableCellReusable {
    static func dequeueingReusableCell(in tableView: UITableView, for indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Self.self),
                                                 for: indexPath) as! Self
        cell.selectionStyle = .none
        return cell
    }
}
