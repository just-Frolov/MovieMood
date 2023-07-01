//
//  TableRegistable.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit

protocol TableRegistable: UITableViewCell {
    
}

extension TableRegistable {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self,
                           forCellReuseIdentifier: String(describing: self))
    }
    
    static func xibRegister(in tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: nil), forCellReuseIdentifier: String(describing: self))
    }
}
