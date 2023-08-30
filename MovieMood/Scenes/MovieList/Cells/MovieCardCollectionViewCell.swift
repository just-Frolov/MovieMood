//
//  MovieCardCollectionViewCell.swift
//  MovieMood
//
//  Created by Danil Frolov on 15.07.2023.
//

import UIKit
import Kingfisher

final class MovieCardCollectionViewCell: BaseCollectionViewCell {
    
    private enum Constant {
        static let cornerRadius: CGFloat = 8
        static let gradientColor = UIColor(white: 0, alpha: 0.4).cgColor
        static let gradientClearColor = UIColor(white: 0, alpha: 0).cgColor
    }

    // MARK: - IBOutlets -
    @IBOutlet private weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.cornerRadius = Constant.cornerRadius
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = FontFamily.Montserrat.bold.font(size: 20)
        }
    }

    // MARK: - Life Cycle -
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    // MARK: - Internal -
    func render(with movieViewState: MovieListViewState.Item) {
        titleLabel.text = movieViewState.title
        posterImageView.kf.setImage(with: movieViewState.posterImagePath)
    }
}
