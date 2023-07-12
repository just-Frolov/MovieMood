//
//  MovieCardTableViewCell.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit
import Kingfisher

final class MovieCardTableViewCell: BaseTableViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let gradientColor = UIColor(white: 0, alpha: 0.4).cgColor
        static let gradientClearColor = UIColor(white: 0, alpha: 0).cgColor
    }
    
    @IBOutlet private weak var backgroundContentView: UIView! {
        didSet {
            backgroundContentView.cornerRadius = Constants.cornerRadius
        }
    }
    @IBOutlet private weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.cornerRadius = Constants.cornerRadius
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = FontFamily.Montserrat.bold.font(size: 20)
        }
    }
    @IBOutlet private weak var bottomGradientView: UIView! {
        didSet {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [Constants.gradientClearColor, Constants.gradientColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = CGRect(
                origin: .zero,
                size: CGSize(width: bottomGradientView.bounds.width, height: bottomGradientView.bounds.height)
            )
            bottomGradientView.layer.addSublayer(gradientLayer)
            bottomGradientView.backgroundColor = .clear
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundContentView.addShadow(with: UIColor.white.cgColor)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    func render(
        with movieViewState: MovieListViewState.MovieViewState,
        _ cellContentInsets: UIEdgeInsets
    ) {
        backgroundContentView.pinEdges(
            to: contentView,
            topSpace: cellContentInsets.top,
            leftSpace: cellContentInsets.left,
            rightSpace: cellContentInsets.right,
            bottomSpace: cellContentInsets.bottom
        )
        titleLabel.text = movieViewState.title
        posterImageView.kf.setImage(with: movieViewState.posterImagePath)
    }
}
