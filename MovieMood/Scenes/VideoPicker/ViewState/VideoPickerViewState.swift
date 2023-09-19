//
//  VideoPickerViewState.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.09.2023.
//

import Foundation

typealias VideoItem = VideoPickerViewState.VideoItem

struct VideoPickerViewState {
    struct VideoItem {
        let title: String
        let publicationDate: String?
        let shouldShowOfficialCheckmark: Bool
    }
    
    let items: [VideoItem]
}

extension VideoItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(publicationDate)
    }
    
    static func == (lhs: VideoItem, rhs: VideoItem) -> Bool {
        return lhs.title == rhs.title && lhs.publicationDate == rhs.publicationDate
    }
}
