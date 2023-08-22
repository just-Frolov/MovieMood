//
//  PlaybackButton.swift
//  MovieMood
//
//  Created by Danil Frolov on 23.08.2023.
//

import UIKit

final class PlaybackButton: UIButton, NibLoadable {
    
    private enum Constants {
        static let borderWidth: CGFloat = 2.0
        static let borderColor: UIColor = .gray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        border(
            width: Constants.borderWidth,
            color: Constants.borderColor
        )
        cornerRadius = height / 2
        backgroundColor = .black
    }
}
