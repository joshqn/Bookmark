//
//  BookMark.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class BookMark: NSManagedObject {
  
  var pageNumberAsText: String {
    get {
      let formatter = NSNumberFormatter()
      guard let page = page else { return "0" }
      guard let number = formatter.stringFromNumber(page) else { return "0" }
      return number
    }
  }
  
  var bookImage: UIImage {
    get {
      guard let photoData = photoData else { return UIImage() }
      guard let image = UIImage(data: photoData) else { return UIImage() }
      return image
    }
  }

}
