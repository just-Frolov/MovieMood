//
//  MovieDetailsViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 16.08.2023.
//

import UIKit

@MainActor
protocol MovieDetailsView: AnyObject {
    func render(with title: String)
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<MovieDetailsDataSource.Section, AnyHashable>)
    func showAlert(title: String?, message: String?, onDismiss: (() -> Void)?)
}

final class MovieDetailsViewController: BaseViewController<MovieDetailsPresenter> {
    
    private enum Constants {
        static let sectionInset = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        static let interGroupSpacing: CGFloat = 16.0
    }
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            dataSource = .init(collectionView: collectionView)
            MovieMediaCollectionViewCell.xibRegister(in: collectionView)
            MovieAttributeCollectionViewCell.xibRegister(in: collectionView)
            collectionView.backgroundColor = .clear
            collectionView.collectionViewLayout = makeCollectionViewLayout()
        }
    }
    
    // MARK: - Variables -
    private var dataSource: MovieDetailsDataSource?
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MovieDetailsViewController: MovieDetailsView {
    func render(with title: String) {
        self.title = title
    }
    
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<MovieDetailsDataSource.Section, AnyHashable>) {
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

private extension MovieDetailsViewController {
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { (setion: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = Constants.sectionInset
            section.interGroupSpacing = Constants.interGroupSpacing
            
            return section
        }
        
        return layout
    }
}


