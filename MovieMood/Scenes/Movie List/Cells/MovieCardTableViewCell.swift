//
//  MovieCardTableViewCell.swift
//  MovieMood
//
//  Created by Danil Frolov on 01.07.2023.
//

import UIKit
import Kingfisher

final class MovieCardTableViewCell: BaseTableViewCell {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = FontFamily.Montserrat.semiBold.font(size: 18)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.kf.cancelDownloadTask()
        backgroundImageView.image = nil
    }
    
    func render(with movieViewState: MovieListViewState.MovieViewState) {
        titleLabel.text = movieViewState.title
        backgroundImageView.kf.setImage(with: movieViewState.posterImagePath)
    }
}
