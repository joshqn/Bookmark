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
  let dateLabel = UILabel()
  let pageLabel = UILabel()
  var bookArtwork = UIImageView()
  var bookmarkButton = UIButton()
  weak var delegate: BookMarksTableViewCellDelegate?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    nameLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
    nameLabel.setContentHuggingPriority(248, forAxis: .Horizontal)
    nameLabel.setContentCompressionResistancePriority(249, forAxis: .Horizontal)
    dateLabel.textColor = .grayColor()
    dateLabel.font = UIFont.systemFontOfSize(16, weight: UIFontWeightMedium)
    pageLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightHeavy)
    pageLabel.setContentHuggingPriority(249, forAxis: .Horizontal)
    bookArtwork.backgroundColor = UIColor.clearColor()
    bookArtwork.layer.borderColor = UIColor.blackColor().CGColor
    bookArtwork.layer.borderWidth = 1.0
    bookmarkButton.setImage(StyleKit.imageOfBookmarkid, forState: .Normal)
    bookmarkButton.setImage(StyleKit.imageOfBookmarkidSelected, forState: .Selected)
    bookmarkButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
    
    let labels = [bookArtwork,nameLabel,dateLabel,pageLabel,bookmarkButton]
    
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
      dateLabel.topAnchor.constraintEqualToAnchor(nameLabel.bottomAnchor,constant: 5),
      dateLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor),
      pageLabel.trailingAnchor.constraintEqualToAnchor(bookmarkButton.leadingAnchor,constant: -5),
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
