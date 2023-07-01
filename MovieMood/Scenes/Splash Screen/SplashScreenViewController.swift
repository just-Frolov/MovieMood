//
//  SplashScreen.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import UIKit
import Lottie

@MainActor
protocol SplashScreenView: AnyObject {
    func showLoadingAnimation() async
    func showError(message: String)
}

final class SplashScreenViewController: BaseViewController<SplashScreenPresenter> {
    
    private enum Constants {
        static let animationViewSpace: CGFloat = 16
    }
    
    static func instantiate(with presenter: SplashScreenPresenter) -> SplashScreenViewController {
        let viewController: SplashScreenViewController = Storyboard.SplashScreen.splashScreenViewController.instantiate()
        viewController.presenter = presenter
        return viewController
    }
  
    //MARK: - UIElements -
    private lazy var loadingAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: Asset.Assets.loading.name)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        return animationView
    }()
 
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
        presenter?.viewDidLoad()
    }
}

extension SplashScreenViewController: SplashScreenView {
    func showLoadingAnimation() async {
        await withCheckedContinuation { continuation in
            loadingAnimationView.play() { _ in
                continuation.resume()
            }
        }
    }
    
    func showError(message: String) {
        showAlert(
            title: Localized.errorTitle,
            message: message
        )
    }
}

private extension SplashScreenViewController {
    func setupAnimationView() {
        view.addSubview(loadingAnimationView)
        loadingAnimationView.pinEdges(
            to: view,
            topSpace: Constants.animationViewSpace,
            leftSpace: Constants.animationViewSpace,
            rightSpace: Constants.animationViewSpace,
            bottomSpace: Constants.animationViewSpace
        )
    }
}
