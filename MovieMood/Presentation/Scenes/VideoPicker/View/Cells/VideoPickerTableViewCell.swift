//
//  VideoPickerTableViewCell.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import UIKit

final class VideoPickerTableViewCell: BaseTableViewCell {

    // MARK: - IBOutlets -
    @IBOutlet private weak var officialCheckmarkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - Internal -
    func render(with videoItem: VideoItem) {
        officialCheckmarkImageView.isHidden = !videoItem.shouldShowOfficialCheckmark
        titleLabel.text = videoItem.title
        dateLabel.text = videoItem.publicationDate
    }
}
