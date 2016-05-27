//
//  ArchiveTableViewCell.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/27/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {
  
  let artwork = UIImageView()
  let bookName = UILabel()
  let statusImage = UIImageView()
  let archiveLabel = UILabel()
  let archivedDate = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    artwork.backgroundColor = UIColor.clearColor()
    artwork.layer.borderColor = UIColor.blackColor().CGColor
    artwork.layer.borderWidth = 1.0
    artwork.setContentCompressionResistancePriority(999, forAxis: .Horizontal)
    
    bookName.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
    bookName.setContentHuggingPriority(249, forAxis: .Horizontal)
    
    archiveLabel.text = "Archived:"
    archiveLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
    archiveLabel.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
    
    archivedDate.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
    archivedDate.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
    
    statusImage.setContentCompressionResistancePriority(999, forAxis: .Horizontal)
    
    let labels = [artwork,bookName,statusImage,archiveLabel,archivedDate]
    
    for label in labels {
      label.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(label)
    }
    
    //Need NSLayoutConstraint to account for fonts getting larger and possibly over lapping
    
    NSLayoutConstraint.activateConstraints([
      artwork.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor,constant: 1),
      artwork.trailingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.trailingAnchor),
      artwork.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      artwork.widthAnchor.constraintEqualToConstant(30),
      
      bookName.topAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.topAnchor),
      bookName.leadingAnchor.constraintEqualToAnchor(statusImage.trailingAnchor,constant: 10),
      bookName.trailingAnchor.constraintEqualToAnchor(artwork.leadingAnchor, constant: -10),
      
      archiveLabel.leadingAnchor.constraintEqualToAnchor(bookName.leadingAnchor),
      archiveLabel.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      
      archivedDate.leadingAnchor.constraintEqualToAnchor(archiveLabel.trailingAnchor,constant: 2),
      archivedDate.bottomAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.bottomAnchor),
      
      statusImage.leadingAnchor.constraintEqualToAnchor(contentView.layoutMarginsGuide.leadingAnchor),
      statusImage.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor)
      
    ])

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
