//
//  UIViewController+FillWithView.swift
//  WhaleTalk
//
//  Created by Joshua Kuehn on 3/21/16.
//  Copyright © 2016 Kuehn LLC. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
  
  func fillViewWith(subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(subview)
    
    let viewConstraints:[NSLayoutConstraint] = [
      subview.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
      subview.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
      subview.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
      subview.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor)
    ]
    NSLayoutConstraint.activateConstraints(viewConstraints)
  }
  
}