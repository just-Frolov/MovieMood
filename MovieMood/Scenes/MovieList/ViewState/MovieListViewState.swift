//
//  MovieListViewState.swift
//  MovieMood
//
//  Created by Danil Frolov on 05.07.2023.
//

import UIKit

typealias MovieListItem = MovieListViewState.Item

struct MovieListViewState {
    struct NavigationBar {
        let title: String
        let rightButtonImage: UIImage
    }
    
    struct Item {
        let id: MovieId
        let title: String
        let posterImagePath: URL?
    }
    
    let navigationBar: NavigationBar
    var items: [Item]
}

extension MovieListItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MovieListItem, rhs: MovieListItem) -> Bool {
        return lhs.id == rhs.id
    }
}

