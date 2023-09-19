//
//  CollectionCellReusable+Registable.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import UIKit

protocol CollectionCellDequeueReusable: UICollectionViewCell, Reusable { }

protocol CollectionCellRegistable: UICollectionViewCell, Reusable { }

extension CollectionCellRegistable {
    static func register(in collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    static func xibRegister(in collectionView: UICollectionView) {
        collectionView.register(
            UINib(nibName: reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier
        )
    }
}

extension CollectionCellDequeueReusable {
    static func dequeueCellWithType(in collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! Self
    }
}
