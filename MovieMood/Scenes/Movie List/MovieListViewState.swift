//
//  MovieListViewState.swift
//  MovieMood
//
//  Created by Danil Frolov on 05.07.2023.
//

import UIKit

struct MovieListViewState {
    struct NavigationBar {
        let title: String
        let rightButtonImage: UIImage
    }
    
    struct Item {
        let id: Int
        let title: String
        let posterImagePath: URL?
    }
    
    let navigationBar: NavigationBar
    var items: [Item]
}

extension MovieListViewState.Item: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MovieListViewState.Item, rhs: MovieListViewState.Item) -> Bool {
        return lhs.id == rhs.id
    }
}

