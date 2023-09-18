//
//  BaseViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

class BaseViewController<Presenter>: UIViewController {
 
    var presenter: Presenter?
    private var alert: UIAlertController?
    private var loadingView: LoadingAnimationView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

extension BaseViewController {
    func inject(
        presenter: Presenter,
        alert: UIAlertController? = nil,
        loadingView: LoadingAnimationView? = nil
    ) {
        self.presenter = presenter
        self.alert = alert
        self.loadingView = loadingView
    }
    
    func showAlert(
        title: String?,
        message: String?,
        onDismiss: (() -> Void)?
    ) {
        guard let alert else { return }
        let action = UIAlertAction(title: Localized.acceptAction, style: .default) { _ in
            onDismiss?()
        }
        
        alert.title = title
        alert.addAction(action)
       
        present(alert, animated: true)
    }
    
    func showLoadingIndicator() async {
        await loadingView?.show(on: self)
    }
    
    func hideLoadingIndicator() {
        loadingView?.hide()
    }
}

private extension BaseViewController {
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setDarkGreyAppearance()
    }
}
