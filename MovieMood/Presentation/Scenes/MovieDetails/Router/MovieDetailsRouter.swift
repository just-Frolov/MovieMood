//
//  MovieDetailsRouter.swift
//  MovieMood
//
//  Created by Danil Frolov on 04.10.2023.
//

import UIKit

protocol MovieDetailsRouter where Self: BaseRouter<Assembly> {
    func showVideoPickerSheet(with videoList: [MovieVideo])
    func finish()
}

final class MovieDetailsRouterImpl: BaseRouter<Assembly>, MovieDetailsRouter {
    func showVideoPickerSheet(with videoList: [MovieVideo]) {
        let videoPickerViewController = assembly.createVideoPickerSheetModule(movieVideoList: videoList)
        videoPickerViewController.modalPresentationStyle = .overFullScreen
        // keep false
        // modal animation will be handled in VC itself
        root.navigationController?.present(videoPickerViewController, animated: false)
    }
    
    func finish() {
        root.navigationController?.popToRootViewController(animated: true)
    }
}

