//
//  Reusable.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit

protocol Reusable { }

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

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

