//
//  NSUserDefaults+isFirstLaunch.swift
//  BookMark
//
//  Created by Joshua Kuehn on 6/8/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation

extension NSUserDefaults {
  
  static func isFirstLaunch() -> Bool {
    let firstLaunchFlag = "firstLaunchFlag"
    //If my NSUserDefault is equal to nil, isFirstLaunch returns true because the string for the key is also nil
    let isFirstLaunch = NSUserDefaults.standardUserDefaults().stringForKey(firstLaunchFlag) == nil
    if (isFirstLaunch) {
      NSUserDefaults.standardUserDefaults().setObject("false", forKey: firstLaunchFlag)
      NSUserDefaults.standardUserDefaults().synchronize()
    }
    return isFirstLaunch
  }
  
}