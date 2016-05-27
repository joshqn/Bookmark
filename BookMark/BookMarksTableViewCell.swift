//
//  BookMarksTableViewCell.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class BookMarksTableViewCell: UITableViewCell {
  
  lazy var formatter: NSNumberFormatter = {
    var formatter = NSNumberFormatter()
    return formatter
  }()

  var page = 0
  let nameLabel = UILabel()
  let authorNameLabel = UILabel()
  let pageLabel = UILabel()
  var bookArtwork = UIImageView()
  var bookmarkButton = UIButton()
  weak var delegate: BookMarksTableViewCellDelegate?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    nameLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
    nameLabel.setContentHuggingPriority(248, forAxis: .Horizontal)
    nameLabel.setContentCompressionResistancePriority(249, forAxis: .Horizontal)
    authorNameLabel.textColor = .grayColor()
    authorNameLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightMedium)
    authorNameLabel.setContentHuggingPriority(248, forAxis: .Horizontal)
    authorNameLabel.setContentCompressionResistancePriority(249, forAxis: .Horizontal)
    pageLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightRegular)
    pageLabel.setContentHuggingPriority(249, forAxis: .Horizontal)
    bookArtwork.backgroundColor = UIColor.clearColor()
    bookArtwork.layer.borderColor = UIColor.blackColor().CGColor
    bookArtwork.layer.borderWidth = 1.0
    bookmarkButton.setImage(StyleKit.imageOfTBCellButtonBMImageFlat, forState: .Normal)
    
    bookmarkButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
    
    let labels = [bookArtwork,nameLabel,authorNameLabel,pageLabel,bookmarkButton]
    
    for label in labels {
      label.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(label)
    }
    
    let constraints: [NSLayoutConstraint] = [
      
      bookArtwork.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
      bookArtwork.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
      bookArtwork.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      bookArtwork.widthAnchor.constraintEqualToConstant(42),
      bookmarkButton.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
      bookmarkButton.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor),
      nameLabel.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
      nameLabel.leadingAnchor.constraintEqualToAnchor(bookArtwork.trailingAnchor,constant: 10),
      nameLabel.trailingAnchor.constraintEqualToAnchor(pageLabel.leadingAnchor,constant: -2),
      authorNameLabel.topAnchor.constraintEqualToAnchor(nameLabel.bottomAnchor,constant: 2),
      authorNameLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor),
      authorNameLabel.trailingAnchor.constraintEqualToAnchor(nameLabel.trailingAnchor,constant: -5),
      pageLabel.trailingAnchor.constraintEqualToAnchor(bookmarkButton.leadingAnchor,constant: -10),
      pageLabel.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor),
      
      
    ]
    
    NSLayoutConstraint.activateConstraints(constraints)
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func buttonTapped() {
    page = Int(formatter.numberFromString(self.pageLabel.text ?? "0") ?? 0)
    delegate?.didPressButtonForCell(self)
  }
  
}

protocol BookMarksTableViewCellDelegate: class {
  func didPressButtonForCell(cell: BookMarksTableViewCell)
}
