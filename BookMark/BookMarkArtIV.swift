//
//  BookMarkArtIV.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/5/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class BookMarkArtIV: UIImageView {
  
  private var tapGesture = UITapGestureRecognizer()
  weak var delegate: BookMarkArtIVDelegate?
  
  init() {
    super.init(frame: CGRectZero)
    self.userInteractionEnabled = true
    tapGesture.addTarget(self, action: #selector(imageViewWasTapped))
    self.addGestureRecognizer(tapGesture)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.userInteractionEnabled = true 
    tapGesture.addTarget(self, action: #selector(imageViewWasTapped))
    self.addGestureRecognizer(tapGesture)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func imageViewWasTapped() {
    delegate?.bookMarkArtIVWasSelected(self)
  }

}

protocol BookMarkArtIVDelegate:class {
  func bookMarkArtIVWasSelected(view: BookMarkArtIV)
}