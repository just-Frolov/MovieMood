//
//  MovieListViewStateFactory.swift
//  MovieMood
//
//  Created by Danil Frolov on 13.07.2023.
//

import UIKit

final class MovieListViewStateFactory {
    func makeViewState(movieList: [Movie]) -> MovieListViewState {
        let navigationBar = MovieListViewState.NavigationBar(
            title: Localized.appTitle,
            rightButtonImage: UIImage()
        )
        
        let movieListItems = makeItems(movieList)
        
        return MovieListViewState(
            navigationBar: navigationBar,
            items: movieListItems
        )
    }
}

private extension MovieListViewStateFactory {
    func makeItems(_ movieList: [Movie]) -> [MovieListViewState.Item] {
        return movieList.map {
            var posterImagePath: URL?
            if let backdropPath = $0.backdropPath {
                posterImagePath = ImageManager
                    .shared
                    .imageURL(
                        withPath: backdropPath,
                        imageSizeType: .list
                    )
            }
            
            return MovieListViewState.Item(
                id: $0.id,
                title: $0.title,
                posterImagePath: posterImagePath
            )
        }
    }
}

