//
//  MovieMediaCollectionViewCell.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//


import UIKit
import Kingfisher

final class MovieMediaCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.kf.indicatorType = .activity
        }
    }
    @IBOutlet private weak var playbackButton: PlaybackButton! {
        didSet {
            playbackButton.isHidden = true
        }
    }

    //MARK: - Life Cycle -
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    //MARK: - Internal -
    func render(with mediaViewState: MovieDetailsViewState.MediaItem) {
        posterImageView.kf.setImage(with: mediaViewState.posterImagePath)
        playbackButton.isHidden = !mediaViewState.shouldShowPlayVideoButton
    }
}
