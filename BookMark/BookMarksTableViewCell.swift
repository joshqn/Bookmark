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
  let dateLabel = UILabel()
  let pageLabel = UILabel()
  var bookArtwork = UIImageView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    nameLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
    dateLabel.textColor = .grayColor()
    dateLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
    pageLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightHeavy)
    bookArtwork.backgroundColor = UIColor.grayColor()
    
    let labels = [bookArtwork,nameLabel,dateLabel,pageLabel]
    
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
      dateLabel.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      dateLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor),
      pageLabel.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
      pageLabel.firstBaselineAnchor.constraintEqualToAnchor(nameLabel.firstBaselineAnchor)
      
    ]
    
    NSLayoutConstraint.activateConstraints(constraints)
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
