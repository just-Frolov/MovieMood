//
//  SplashScreen.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import UIKit

protocol SplashScreenView {
    
}

final class SplashScreenViewController: UIViewController {
    
    static func instantiate(with presenter: SplashScreenPresenter) -> SplashScreenViewController {
        let vc: SplashScreenViewController = Storyboard.SplashScreen.splashScreenViewController.instantiate()
        vc.presenter = presenter
        return vc
    }
  
    //MARK: - Variables -
    var presenter: SplashScreenPresenter?
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SplashScreenViewController: SplashScreenView {
    
}
