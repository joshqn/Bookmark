//
//  PopUpView.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/23/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class PopUpView: UIView {
  
  let topLayer = CAShapeLayer()
  let saveButton = UIButton(type: .Custom)
  let picker = UIPickerView()
  let bookName = UITextField()
  let numberOfPagesLabel = UILabel()
  let numberOfPagesReadTextField = UITextField()
  let bmbuttonImage = StyleKit.imageOfPopUpViewBM
  
  override init(frame: CGRect) {
    super.init(frame: frame)

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    drawTopBackgroundLayer(topLayer)
    setup()
  }
  
  func setup() {
    
    saveButton.setImage(bmbuttonImage, forState: .Normal)
    
    self.addSubview(saveButton)
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -15).active = true
    saveButton.bottomAnchor.constraintEqualToAnchor(self.topAnchor,constant: 89).active = true
    saveButton.setContentHuggingPriority(999, forAxis: .Horizontal)
    saveButton.setContentCompressionResistancePriority(999, forAxis: .Horizontal)
    
    self.addSubview(picker)
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.topAnchor.constraintEqualToAnchor(saveButton.bottomAnchor,constant: -10).active = true
    picker.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor,constant: 15).active = true
    picker.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: 0).active = true
    picker.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -15).active = true
    
    self.addSubview(bookName)
    bookName.font = UIFont.systemFontOfSize(20, weight: UIFontWeightMedium)
    bookName.textColor = UIColor.whiteColor()
    bookName.translatesAutoresizingMaskIntoConstraints = false
    bookName.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor,constant: 15).active = true
    bookName.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 8).active = true
    bookName.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -5).active = true
    
    self.addSubview(numberOfPagesLabel)
    numberOfPagesLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightThin)
    numberOfPagesLabel.textColor = UIColor.whiteColor()
    numberOfPagesLabel.text = "Pages Read:"
    numberOfPagesLabel.translatesAutoresizingMaskIntoConstraints = false
    numberOfPagesLabel.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor,constant: 15).active = true
    numberOfPagesLabel.topAnchor.constraintEqualToAnchor(self.bookName.bottomAnchor, constant: 3).active = true
    
    self.addSubview(numberOfPagesReadTextField)
    numberOfPagesReadTextField.font = UIFont.systemFontOfSize(18, weight: UIFontWeightThin)
    numberOfPagesReadTextField.textColor = UIColor.whiteColor()
    numberOfPagesReadTextField.translatesAutoresizingMaskIntoConstraints = false
    numberOfPagesReadTextField.leadingAnchor.constraintEqualToAnchor(self.numberOfPagesLabel.trailingAnchor,constant: 5).active = true
    numberOfPagesReadTextField.topAnchor.constraintEqualToAnchor(self.bookName.bottomAnchor, constant: 3).active = true
    numberOfPagesReadTextField.trailingAnchor.constraintEqualToAnchor(saveButton.leadingAnchor, constant: -5).active = true
  }
  
  func drawTopBackgroundLayer(layer: CAShapeLayer) {
    layer.path = UIBezierPath(roundedRect: CGRect(x: 0,y: 0,width: self.frame.width,height: 65), byRoundingCorners: [UIRectCorner.TopLeft, UIRectCorner.TopRight], cornerRadii: CGSize(width: 8, height: 8)).CGPath
    layer.fillColor = StyleKit.mainTintColor.CGColor
    self.layer.addSublayer(layer)
  }


}

