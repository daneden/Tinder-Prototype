//
//  CustomSegue.swift
//  WK4-Exercise
//
//  Created by Daniel Eden on 8/27/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class CustomSegue: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool!
    var duration = 0.4
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        
        
        if (isPresenting == true) {
            
            toViewController.view.alpha = 0
            
            containerView.addSubview(toViewController.view)
            
            UIView.animateWithDuration(duration, animations: {
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        
        } else {
            
            UIView.animateWithDuration(duration, animations: {
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    fromViewController.removeFromParentViewController()
                    transitionContext.completeTransition(true)
            }
        
        }
        
    }
   
}
