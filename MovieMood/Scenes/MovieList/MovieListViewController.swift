//
//  HomeScreenView.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

@MainActor
protocol MovieListView: AnyObject {
    func render(with navigationBar: MovieListViewState.NavigationBar)
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<Int, AnyHashable>)
    func showLoadingIndicator() async
    func hideLoadingIndicator()
}

final class MovieListViewController: BaseViewController<MovieListPresenter> {
    
    private enum Constants {
        static let sectionInset = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        static let interGroupSpacing: CGFloat = 16.0
    }
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            dataSource = .init(collectionView: collectionView)
            MovieCardCollectionViewCell.xibRegister(in: collectionView)
            collectionView.backgroundColor = .clear
            collectionView.collectionViewLayout = makeCollectionViewLayout()
            collectionView.delegate = self
        }
    }
    
    //MARK: - Variables -
    private var dataSource: MovieListDataSource?
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MovieListViewController: MovieListView {
    func render(with navigationBar: MovieListViewState.NavigationBar) {
        title = navigationBar.title
    }
    
    func setDataSource(snapshot: NSDiffableDataSourceSnapshot<Int, AnyHashable>) {
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.itemIdentifier(for: indexPath) as? MovieListViewState.Item {
            presenter?.didSelect(item: item)
        }
    }
}

private extension MovieListViewController {
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [unowned self] (setion: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
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
            
            section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                guard let self, let indexPath = items.last?.indexPath else { return }
                
                self.presenter?.fetchMoviesIfNeeded(indexPath: indexPath)
            }
            
            return section
        }
        
        return layout
    }
}


