//
//  BaseViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

class BaseViewController<Presenter>: UIViewController {
 
    var presenter: Presenter?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension BaseViewController {
    func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}