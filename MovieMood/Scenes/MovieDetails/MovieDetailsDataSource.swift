//
//  MovieDetailsDataSource.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.08.2023.
//

import UIKit

final class MovieDetailsDataSource: UICollectionViewDiffableDataSource<MovieDetailsDataSource.Section, AnyHashable> {
    enum Section: Hashable {
        case media
        case attributes
    }
    
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            if let mediaItem = item as? MovieDetailsViewState.MediaItem {
                let cell = MovieMediaCollectionViewCell
                    .dequeueCellWithType(in: collectionView, indexPath: indexPath)
                cell.render(with: mediaItem)
                return cell
            } else if let attributeItem = item as? MovieDetailsViewState.AttributeItem {
                let cell = MovieAttributeCollectionViewCell
                    .dequeueCellWithType(in: collectionView, indexPath: indexPath)
                cell.render(with: attributeItem)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
}
