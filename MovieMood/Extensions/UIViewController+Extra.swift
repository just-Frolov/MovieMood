//
//  UIViewController+Extra.swift
//  MovieMood
//
//  Created by Danil Frolov on 28.05.2023.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil, onDismiss: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Localized.acceptAction, style: .default) { _ in
            onDismiss?()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
