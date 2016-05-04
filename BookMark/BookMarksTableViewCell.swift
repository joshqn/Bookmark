//
//  BookMarksTableViewCell.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class BookMarksTableViewCell: UITableViewCell {

  let nameLabel = UILabel()
  let messageLabel = UILabel()
  let dateLabel = UILabel()
  let bookArtwork = UIImageView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    nameLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightBold)
    messageLabel.textColor = .grayColor()
    dateLabel.textColor = .grayColor()
    bookArtwork.backgroundColor = UIColor.grayColor()
    
    let labels = [bookArtwork,nameLabel,messageLabel,dateLabel]
    
    for label in labels {
      label.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(label)
    }
    
    let constraints: [NSLayoutConstraint] = [
      
      bookArtwork.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
      bookArtwork.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
      bookArtwork.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      bookArtwork.widthAnchor.constraintEqualToConstant(40),
      nameLabel.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
      nameLabel.leadingAnchor.constraintEqualToAnchor(bookArtwork.trailingAnchor,constant: 10),
      messageLabel.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      messageLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor),
      dateLabel.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
      dateLabel.firstBaselineAnchor.constraintEqualToAnchor(nameLabel.firstBaselineAnchor)
      
    ]
    
    NSLayoutConstraint.activateConstraints(constraints)
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
