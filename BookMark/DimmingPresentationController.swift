//
//  DimmingPresentationController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/19/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation
import UIKit

class DimmingPresentationController: UIPresentationController {
  lazy var dimmingView = GradientView(frame: CGRect.zero)
  
  override func shouldRemovePresentersView() -> Bool {
    return false 
  }
  
  override func presentationTransitionWillBegin() {
    dimmingView.frame = containerView!.bounds
    containerView!.insertSubview(dimmingView, atIndex: 0)
    
    dimmingView.alpha = 0
    if let transitionCoordinator = presentedViewController.transitionCoordinator() {
      transitionCoordinator.animateAlongsideTransition({ _ in
        self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
  }
  
  override func dismissalTransitionWillBegin() {
    if let transitionCoordinator = presentedViewController.transitionCoordinator() {
      transitionCoordinator.animateAlongsideTransition({ _ in
        self.dimmingView.alpha = 0
        }, completion: nil)
    }
  }
  
  
}