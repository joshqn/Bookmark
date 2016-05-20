//
//  SlideOutAnimationController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/19/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation
import UIKit

class SlideOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.33
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey), let containerView = transitionContext.containerView() {
      let duration = transitionDuration(transitionContext)
      
      UIView.animateWithDuration(duration, animations: {
        fromView.center.y -= containerView.bounds.size.height
        fromView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        }, completion: { finished in
          transitionContext.completeTransition(finished)
      })
    }
  }
}
