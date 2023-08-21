//
//  MovieDetailsDataSource.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.08.2023.
//

import UIKit

final class MovieDetailsDataSource: UICollectionViewDiffableDataSource<Int, AnyHashable> {
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
