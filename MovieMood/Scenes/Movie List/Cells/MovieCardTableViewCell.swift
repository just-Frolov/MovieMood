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
    }
    
    @IBOutlet private weak var backgroundContentView: UIView! {
        didSet {
            backgroundContentView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = FontFamily.Montserrat.semiBold.font(size: 18)
        }
    }
    
    @IBOutlet private weak var contentLeadingInset: NSLayoutConstraint!
    @IBOutlet private weak var contentTrailingInset: NSLayoutConstraint!
    @IBOutlet private weak var contentTopInset: NSLayoutConstraint!
    @IBOutlet private weak var contentBottomInset: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundContentView.cornerRadius = Constants.cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.kf.cancelDownloadTask()
        backgroundImageView.image = nil
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
        backgroundImageView.kf.setImage(with: movieViewState.posterImagePath)
    }
}
