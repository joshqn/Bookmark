//
//  TodayTBCell.swift
//  BookMark
//
//  Created by Joshua Kuehn on 7/29/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class TodayTBCell: UITableViewCell {
  
  let nameLabel = UILabel()
  let pageLabel = UILabel()
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    nameLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
    nameLabel.textColor = UIColor.whiteColor()
    nameLabel.setContentHuggingPriority(248, forAxis: .Horizontal)
    nameLabel.setContentCompressionResistancePriority(249, forAxis: .Horizontal)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(nameLabel)
    
    pageLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightLight)
    pageLabel.textColor = UIColor.whiteColor()
    pageLabel.setContentHuggingPriority(249, forAxis: .Horizontal)
    pageLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(pageLabel)
    
    let constraints: [NSLayoutConstraint] = [
      nameLabel.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor),
      nameLabel.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: 15),
      nameLabel.trailingAnchor.constraintEqualToAnchor(self.pageLabel.leadingAnchor, constant: -10),
      pageLabel.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor),
      pageLabel.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor,constant: -15)
    ]
    
    NSLayoutConstraint.activateConstraints(constraints)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
