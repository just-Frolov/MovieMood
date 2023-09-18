//
//  BaseViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 02.06.2023.
//

import UIKit

class BaseViewController<Presenter>: UIViewController {
 
    var presenter: Presenter?
    private var alert: AlertPresentable?
    private var loadingView: LoadingAnimationView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

extension BaseViewController {
    func inject(
        presenter: Presenter,
        alert: AlertPresentable? = nil,
        loadingView: LoadingAnimationView? = nil
    ) {
        self.presenter = presenter
        self.alert = alert
        self.loadingView = loadingView
    }
    
    func showAlert(
        title: String?,
        message: String?,
        onDismiss: @escaping (() -> Void)
    ) {
        guard let alert else { return }
        let action = AlertViewState.Action(title: Localized.acceptAction, event: onDismiss)
        
        let viewState = AlertViewState(
            title: title,
            message: message,
            actions: [action]
        )
        alert.configure(with: viewState)
       
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
