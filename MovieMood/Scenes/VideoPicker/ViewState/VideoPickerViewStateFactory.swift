//
//  VideoPickerViewStateFactory.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.09.2023.
//

import UIKit

final class VideoPickerViewStateFactory {
    func makeViewState(_ movieVideoList: [MovieVideo]) -> VideoPickerViewState {
        
        let videoItems = movieVideoList.compactMap { movieVideo in
            var publicationDisplayDate: String? = nil
            
            if let publicationDate = movieVideo.publicationDate {
                publicationDisplayDate = DateHelper.toDateWithoutTime(from: publicationDate)
            }
            
            return VideoItem(
                title: movieVideo.name,
                publicationDate: publicationDisplayDate,
                shouldShowOfficialCheckmark: movieVideo.official
            )
        }
        
        return VideoPickerViewState(items: videoItems)
    }
}
