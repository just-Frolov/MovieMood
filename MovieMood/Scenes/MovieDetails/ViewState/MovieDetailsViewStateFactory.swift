//
//  MovieDetailsViewStateFactory.swift
//  MovieMood
//
//  Created by Danil Frolov on 17.08.2023.
//

import Foundation

import UIKit

final class MovieDetailsViewStateFactory {
    func makeInitialViewState(configuration: MovieDetailsConfiguration) -> MovieDetailsViewState {
        return MovieDetailsViewState(
            title: configuration.title,
            mediaItems: nil,
            attributeItems: nil
        )
    }
    
    func makeViewState(movieDetails: MovieDetails, videoList: [MovieVideo]?) -> MovieDetailsViewState {
        
        let mediaItems = makeMediaItems(by: movieDetails, videoList: videoList)
        let attributeItems = makeAttributeItems(by: movieDetails)

        return MovieDetailsViewState(
            title: movieDetails.title,
            mediaItems: mediaItems,
            attributeItems: attributeItems
        )
    }
}

private extension MovieDetailsViewStateFactory {
    func makeMediaItems(by movieDetails: MovieDetails, videoList: [MovieVideo]?) -> [MediaItem]? {
        let shouldShowPlayVideoButton = !videoList.isNilOrEmpty
        
        if let backdropPath = movieDetails.backdropPath {
            guard let posterImagePath = ImageManager
                .imageURL(
                    withPath: backdropPath,
                    imageSizeType: .details
                ) else { return nil }
            
            return [MediaItem(
                shouldShowPlayVideoButton: shouldShowPlayVideoButton,
                posterImagePath: posterImagePath
            )]
        }
        
        return nil
    }
    
    func makeAttributeItems(by movieDetails: MovieDetails) -> [AttributeItem] {
        var items: [AttributeItem] = []
        
        items.append(.originalTitle(movieDetails.originalTitle))
        items.append(.description(movieDetails.overview))
        items.append(.rating(String(movieDetails.voteAverage)))
        
        if let releaseDate = movieDetails.releaseDate {
            items.append(.releaseDate(releaseDate))
        }
        
        if !movieDetails.productionCountries.isEmpty {
            let productionCountryNameList = movieDetails.productionCountries.map {
                $0.name
            }
            let combinedNameList = productionCountryNameList.joined(separator: ", ")
            items.append(.productionCountries(combinedNameList))
        }

        if movieDetails.budget != .zero {
            let formattedBudget = PriceFormatter.toDecimalWithUSD(from: movieDetails.budget)
            items.append(.budget(formattedBudget))
        }
        
        if movieDetails.revenue != .zero {
            let formattedRevenue = PriceFormatter.toDecimalWithUSD(from: movieDetails.revenue)
            items.append(.revenue(formattedRevenue))
        }

        return items
    }
}
