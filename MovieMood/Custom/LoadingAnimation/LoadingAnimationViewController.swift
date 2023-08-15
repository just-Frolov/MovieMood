//
//  LoadingAnimationViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 11.04.2023.
//

import UIKit
import Lottie

@MainActor
protocol LoadingAnimationView: AnyObject {
    func show(on viewController: UIViewController) async
    func hide()
}

final class LoadingAnimationViewController: UIViewController {
    
    private enum Constants {
        static let animationViewSpace: CGFloat = 16
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
        view.backgroundColor = .black
        setupAnimationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension LoadingAnimationViewController: LoadingAnimationView {
    func show(on viewController: UIViewController) async {
        viewController.addChild(self)
        viewController.view.addSubview(view)
        view.pinEdges(to: viewController.view)
        
        await withCheckedContinuation { continuation in
            loadingAnimationView.play() { _ in
                continuation.resume()
            }
        }
    }
    
    func hide() {
        loadingAnimationView.stop()
        view.removeFromSuperview()
    }
}

private extension LoadingAnimationViewController {
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
