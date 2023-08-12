//
//  BaseViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

class BaseViewController<Presenter>: UIViewController {
 
    var presenter: Presenter?
    var alert: UIAlertController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

extension BaseViewController {
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        guard let alert else { return }
        let action = UIAlertAction(title: Localized.acceptAction, style: .default) { _ in
            onDismiss?()
        }
        
        alert.title = title
        alert.addAction(action)
       
        present(alert, animated: true)
    }
}

private extension BaseViewController {
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setDarkGreyAppearance()
    }
}
