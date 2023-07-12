//
//  BaseViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

class BaseViewController<Presenter>: UIViewController {
    
    var presenter: Presenter?
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
}

extension BaseViewController {
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Localized.acceptAction, style: .default) { _ in
            onDismiss?()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

private extension BaseViewController {
    func setupUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setDarkGreyAppearance()
    }
}
