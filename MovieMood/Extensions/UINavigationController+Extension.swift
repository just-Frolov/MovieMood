//
//  UINavigationController+Extension.swift
//  MovieMood
//
//  Created by Danil Frolov on 12.07.2023.
//

import UIKit

extension UINavigationController {
    
    /// Call this function from `viewWillAppear` in view controller.
    func setDarkGreyAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Asset.Colors.darkGrey.color
        
        let textAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: FontFamily.Montserrat.bold.font(size: 20)
        ]
        appearance.titleTextAttributes = textAttributes
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
