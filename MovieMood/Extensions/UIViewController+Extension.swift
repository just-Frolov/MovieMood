//
//  UIViewController+Extension.swift
//  MovieMood
//
//  Created by Danil Frolov on 19.09.2023.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
