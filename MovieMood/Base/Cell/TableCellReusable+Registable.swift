//
//  TableCellReusable+Registable.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import UIKit

protocol TableCellDequeueReusable: UITableViewCell, Reusable { }

protocol TableCellRegistable: UITableViewCell, Reusable { }

extension TableCellDequeueReusable {
    static func dequeueingReusableCell(in tableView: UITableView, for indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath) as! Self
        cell.selectionStyle = .none
        return cell
    }
}

extension TableCellRegistable {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self,
                           forCellReuseIdentifier: reuseIdentifier)
    }
    
    static func xibRegister(in tableView: UITableView) {
        tableView.register(
            UINib(nibName: String(describing: self), bundle: nil),
            forCellReuseIdentifier: reuseIdentifier
        )
    }
}
