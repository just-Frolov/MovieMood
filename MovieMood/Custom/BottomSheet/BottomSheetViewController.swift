//
//  BottomSheetViewController.swift
//  MovieMood
//
//  Created by Danil Frolov on 18.09.2023.
//

import UIKit

@objc
protocol Dismissable where Self: UIView {
    var dismissAction: (() -> Void)? { get set }
}

final class BottomSheetViewController: UIViewController {
    
    private enum Constant {
        static let contentCornerRadius: CGFloat = 16
        static let maxDimmedAlpha: CGFloat = 0.6
        static let defaultHeight: CGFloat = UIScreen.main.bounds.height / 2
        static let dismissibleHeight: CGFloat = 200
        static let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height / 2
    }
    
    // MARK: - Variables -
    private var currentContainerHeight: CGFloat = Constant.defaultHeight
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var dimmedView: UIView! {
        didSet {
            dimmedView.alpha = Constant.maxDimmedAlpha
        }
    }
    @IBOutlet private weak var contentView: Dismissable! {
        didSet {
            contentView.cornerRadius = Constant.contentCornerRadius
        }
    }
    
    // Dynamic content constraint
    @IBOutlet private var contentViewHeightConstraint: NSLayoutConstraint! {
        didSet {
            contentViewHeightConstraint.constant = Constant.defaultHeight
        }
    }
    @IBOutlet private var contentViewBottomConstraint: NSLayoutConstraint! {
        didSet {
            contentViewBottomConstraint.constant = -Constant.defaultHeight
        }
    }
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentDimmedView()
        animatePresentContentView()
    }
}

private extension BottomSheetViewController {
    func animatePresentContentView() {
        UIView.animate(withDuration: 0.3) {
            self.contentViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animatePresentDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = Constant.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = Constant.maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
       
        UIView.animate(withDuration: 0.3) {
            self.contentViewBottomConstraint?.constant = -Constant.defaultHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.contentViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        let isDraggingDown = translation.y > 0
        
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < Constant.maximumContainerHeight {
                contentViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            if newHeight < Constant.dismissibleHeight {
                // Condition 1: If new height is below min, dismiss controller
                self.animateDismissView()
            }
            else if newHeight < Constant.defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(Constant.defaultHeight)
            }
            else if newHeight < Constant.maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(Constant.defaultHeight)
            }
            else if newHeight > Constant.defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(Constant.maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
}
