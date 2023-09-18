//
//  MovieDetailsViewState.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.08.2023.
//

import UIKit

typealias MediaItem = MovieDetailsViewState.MediaItem
typealias AttributeItem = MovieDetailsViewState.AttributeItem

struct MovieDetailsViewState {
    struct MediaItem {
        let shouldShowPlayVideoButton: Bool
        let posterImagePath: URL
    }
    
    enum AttributeItem {
        case originalTitle(String)
        case description(String)
        case rating(String)
        case releaseDate(String)
        case productionCountries(String)
        case budget(String)
        case revenue(String)
        
        var displayTitle: String {
            switch self {
            case .originalTitle:
                return Localized.originalTitle
            case .description:
                return Localized.description
            case .rating:
                return Localized.rating
            case .releaseDate:
                return Localized.releaseDate
            case .productionCountries:
                return Localized.productionCountries
            case .budget:
                return Localized.budget
            case .revenue:
                return Localized.revenue
            }
        }
        
        var valueText: String {
            switch self {
            case .originalTitle(let title):
                return title
            case .description(let description):
                return description
            case .rating(let rating):
                return rating
            case .releaseDate(let releaseDate):
                return releaseDate
            case .productionCountries(let countries):
                return countries
            case .budget(let budget):
                return budget
            case .revenue(let revenue):
                return revenue
            }
        }
    }
        
    let title: String
    let mediaItems: [MediaItem]?
    let attributeItems: [AttributeItem]?
}

extension MediaItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(posterImagePath)
    }

    static func == (lhs: MediaItem, rhs: MediaItem) -> Bool {
        return lhs.posterImagePath == rhs.posterImagePath
    }
}

extension AttributeItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(displayTitle)
    }

    static func == (lhs: AttributeItem, rhs: AttributeItem) -> Bool {
        return lhs.displayTitle == rhs.displayTitle
    }
}

