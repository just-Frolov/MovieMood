//
//  MovieListDataSource.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit

final class MovieListDataSource: UICollectionViewDiffableDataSource<Int, AnyHashable> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            if let movieItem = item as? MovieListViewState.Item {
                let cell = MovieCardCollectionViewCell
                    .dequeueCellWithType(in: collectionView, indexPath: indexPath)
                cell.render(with: movieItem)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
}
