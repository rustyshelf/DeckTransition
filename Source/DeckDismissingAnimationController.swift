//
//  DeckDismissingAnimationController.swift
//  DeckTransition
//
//  Created by Harshil Shah on 15/10/16.
//  Copyright © 2016 Harshil Shah. All rights reserved.
//

import UIKit

final class DeckDismissingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Private variables
    
    private let duration: TimeInterval?
    private let customLargeScreenSize: Bool
    
    // MARK: - Initializers
    
    init(duration: TimeInterval?, customLargeScreenSize: Bool) {
        self.duration = duration
        self.customLargeScreenSize = customLargeScreenSize
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        /// The presentedViewController throughout this library refers to the
        /// card view controller which is presented in the Deck style, and so
        /// for consistency, even through it's the view controller that we are
        /// transitioning `.from` in the context of the dismissal animation and
        /// should thus be the `presentingViewController`, it's referred to as
        /// the `presentedViewController` here
        
        guard let presentedViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        let offscreenFrame = ManualLayout.presentFrame(availableWidth: containerView.bounds.width, height: containerView.bounds.height, y: containerView.bounds.height, customLargeScreenSize: customLargeScreenSize)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseOut,
            animations: {
                presentedViewController.view.frame = offscreenFrame
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration ?? Constants.defaultAnimationDuration
    }
    
}

