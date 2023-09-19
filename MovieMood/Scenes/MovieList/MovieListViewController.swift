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
    
    private enum Constant {
        static let sectionInset = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        static let interGroupSpacing: CGFloat = 16.0
        static let movieImageRatio: CGFloat = 1.78
    }
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            dataSource = .init(collectionView: collectionView)
            MovieCardCollectionViewCell.xibRegister(in: collectionView)
            collectionView.backgroundColor = .clear
            collectionView.keyboardDismissMode = .onDrag
            collectionView.collectionViewLayout = makeCollectionViewLayout()
            collectionView.delegate = self
        }
    }
    
    // MARK: - UIElements -
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = Localized.searchPlaceholder
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    // MARK: - Variables -
    private var dataSource: MovieListDataSource?
    private var imageHeight: CGFloat = 0
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        presenter?.perform(
            action: .viewDidLoad
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageHeight = collectionView.width / Constant.movieImageRatio
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
        if let item = dataSource?.itemIdentifier(for: indexPath) as? MovieListItem {
            presenter?.perform(
                action: .select(item: item)
            )
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.perform(
            action: .search(query: searchText, forceUpdate: false)
        )
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.perform(
            action: .search(query: searchBar.text, forceUpdate: true)
        )
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.perform(
            action: .search(query: nil, forceUpdate: true)
        )
    }
}

private extension MovieListViewController {
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [unowned self] (setion: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(self.imageHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = Constant.sectionInset
            section.interGroupSpacing = Constant.interGroupSpacing
            
            section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                guard let self, let indexPath = items.last?.indexPath else { return }
                
                self.presenter?.perform(
                    action: .scroll(indexPath: indexPath)
                )
            }
            
            return section
        }
        
        return layout
    }
}


