//
//  AlertPresentable.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import UIKit

struct AlertViewState {
    struct Action {
        let title: String
        let event: (() -> Void)
    }
    
    let title: String?
    let message: String?
    let actions: [Action]
}

protocol AlertPresentable where Self: UIAlertController {
    func configure(with viewState: AlertViewState)
}

final class AlertController: UIAlertController, AlertPresentable {
    func configure(with viewState: AlertViewState) {
        title = viewState.title
        message = viewState.message
        
        viewState.actions.forEach { item in
            let action = UIAlertAction(title: item.title, style: .default) { _ in
                item.event()
            }
            addAction(action)
        }
    }
}
