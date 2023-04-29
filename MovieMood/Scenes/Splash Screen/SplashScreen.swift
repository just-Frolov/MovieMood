//
//  SplashScreen.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import UIKit
import AVFoundation

protocol SplashScreenView: AnyObject {
    func didLoadPlayer(playerLayer: AVPlayerLayer)
}

final class SplashScreenViewController: BaseViewController<SplashScreenPresenter> {

    private var playerLayer: AVPlayerLayer?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onAppear()
    }
}

// MARK: - SplashScreenView
extension SplashScreenViewController: SplashScreenView {
    func didLoadPlayer(playerLayer: AVPlayerLayer) {
        self.playerLayer = playerLayer
        view.layer.insertSublayer(playerLayer, at: 0)
    }
}
