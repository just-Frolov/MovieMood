//
//  MovieAttributeCollectionViewCell.swift
//  MovieMood
//
//  Created by Danil Frolov on 21.08.2023.
//

import UIKit

final class MovieAttributeCollectionViewCell: BaseCollectionViewCell {

    // MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!

    // MARK: - Internal -
    func render(with attributeViewState: AttributeItem) {
        titleLabel.text = attributeViewState.displayTitle
        valueLabel.text = attributeViewState.valueText
    }
}
