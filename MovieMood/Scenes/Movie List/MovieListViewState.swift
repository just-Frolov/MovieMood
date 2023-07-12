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
    
    struct MovieViewState: Hashable {
        let id: Int
        let title: String
        let posterImagePath: URL?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: MovieViewState, rhs: MovieViewState) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    let navigationBar: NavigationBar
    let movies: [MovieViewState]
}

extension MovieListViewState {
    static func makeViewState(
        movieList: [Movie]
    ) -> MovieListViewState {
        let navigationBar = NavigationBar(
            title: Localized.appTitle,
            rightButtonImage: UIImage()
        )
        
        
        let movieViewModelList = movieList.map {
            var posterImagePath: URL?
            if let backdropPath = $0.backdropPath {
                posterImagePath = ImageManager
                    .shared
                    .imageURL(
                        withPath: backdropPath
                    )
            }
            
            return MovieViewState(
                id: $0.id,
                title: $0.title,
                posterImagePath: posterImagePath
            )
        }
        
        return MovieListViewState(
            navigationBar: navigationBar,
            movies: movieViewModelList
        )
    }
}
