//
//  UIView+Extra.swift
//  MovieMood
//
//  Created by Danil Frolov on 22.05.2023.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.masksToBounds = true
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor {
        get {
            return layer.borderColor ?? UIColor.clear.cgColor
        }
        set {
            layer.masksToBounds = true
            layer.borderColor = newValue
        }
    }
    
    func addDropShadow(offset: CGSize,
                       color: UIColor,
                       radius: CGFloat = 0,
                       opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func roundCorners(_ corners: CACornerMask = .all,
                      radius: CGFloat) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func cornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func border(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}

extension CACornerMask {
    static let all: CACornerMask = [
        .layerMaxXMaxYCorner,
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMinYCorner
    ]
}

