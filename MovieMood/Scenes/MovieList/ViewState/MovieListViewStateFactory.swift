//
//  MovieListViewStateFactory.swift
//  MovieMood
//
//  Created by Danil Frolov on 13.07.2023.
//

import UIKit

final class MovieListViewStateFactory {
    private enum Constants {
        static let expandImage = UIImage(systemName: "arrow.left.and.line.vertical.and.arrow.right")
        static let reduceImage = UIImage(systemName: "arrow.right.and.line.vertical.and.arrow.left")
    }
    
    private var layoutStyle: MovieListViewState.LayoutStyle = .singleColumn
    
    func makeViewState(movieList: [Movie], shouldChangeLayout: Bool) -> MovieListViewState {
        if shouldChangeLayout {
            changeLayoutStyle()
        }
        let rightButtonImage = layoutStyle == .singleColumn ? Constants.expandImage : Constants.reduceImage
        let navigationBar = MovieListViewState.NavigationBar(
            title: Localized.appTitle,
            rightButtonImage: rightButtonImage ?? UIImage()
        )
        
        let movieListItems = makeItems(movieList)
        
        return MovieListViewState(
            layoutStyle: layoutStyle,
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
    
    func changeLayoutStyle() {
        switch layoutStyle {
        case .singleColumn:
            layoutStyle = .multiColumns
        case .multiColumns:
            layoutStyle = .singleColumn
        }
    }
}

