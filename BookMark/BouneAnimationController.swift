//
//  BouneAnimationController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/19/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation
import UIKit

class BounceAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.4
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey), let toView = transitionContext.viewForKey(UITransitionContextToViewKey),let containerView = transitionContext.containerView() {
      toView.frame = transitionContext.finalFrameForViewController(toViewController)
      containerView.addSubview(toView)
      
      let transform = makePerspectiveTransform()
      
      var transformRotate = self.makePerspectiveTransform()
      var transformScale = self.makePerspectiveTransform()
      
      transformRotate = CATransform3DRotate(transform, CGFloat(-M_PI/2), 0, 1, 0)
      transformScale = CATransform3DScale(transform, 0.6, 0.6, 1.0)
      var concat = CATransform3DConcat(transformRotate, transformScale)
      
      toView.layer.transform = concat
      
      transformRotate = CATransform3DRotate(transform, 0, 0, 1, 0)
      transformScale = CATransform3DScale(transform, 1.0, 1.0, 1.0)
      concat = CATransform3DConcat(transformRotate, transformScale)
      //transform = CATransform3DTranslate(transform, -0.7 * 100, 0, 0)
      
      toView.layer.zPosition = 120
      
      UIView.animateKeyframesWithDuration(transitionDuration(transitionContext), delay: 0.1, options: .CalculationModeCubic, animations: {
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
          
          toView.layer.transform = concat
          
        })
        }, completion: { finished in
          transitionContext.completeTransition(finished)
      })
      
    }
  }
  
  func makePerspectiveTransform() -> CATransform3D {
    var transform = CATransform3DIdentity
    transform.m34 = 1.0 / (-2000)
    return transform
  }
  
  
  
}