//
//  MovieDetailsViewState.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.08.2023.
//

import UIKit

struct MovieDetailsViewState {
    struct NavigationBar {
        let title: String
    }
    
    enum DescriptionType {
        
    }
    
    let navigationBar: NavigationBar
    let videoURL: URL?
    let placeholderImage: UIImage
    let title: String
    let description: String
}
//
//extension MovieDetailsViewState.Item: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(title)
//    }
//
//    static func == (lhs: MovieListViewState.Item, rhs: MovieListViewState.Item) -> Bool {
//        return lhs.id == rhs.id
//    }
//}

