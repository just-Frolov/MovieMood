//
//  HomeScreenView.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

@MainActor
protocol HomeScreenView: AnyObject {
    
}

final class HomeScreenViewController: BaseViewController<HomeScreenPresenter> {
    
    private enum Constants {

    }
    
    static func instantiate(with presenter: HomeScreenPresenter) -> HomeScreenViewController {
        let vc: HomeScreenViewController = Storyboard.HomeScreen.homeScreenViewController.instantiate()
        vc.presenter = presenter
        return vc
    }
  
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension HomeScreenViewController: HomeScreenView {

}

private extension HomeScreenViewController {
 
}

