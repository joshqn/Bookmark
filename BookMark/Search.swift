//
//  Search.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/7/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation
import Alamofire

class Search {
  
  class func sendMyApiRequest(bookName:String, completion:(url:NSURL) -> Void) {
    
    // Add URL parameters
    let urlParams = [
      "term":bookName,
      "limit":"8",
      "entity":"ebook",
      ]
    
    // Fetch Request
    Alamofire.request(.GET, "http://itunes.apple.com/search", parameters: urlParams)
      .validate(statusCode: 200..<300)
      .responseJSON { response in
        if (response.result.error == nil) {
          guard let response = response.result.value as? NSDictionary else { return }
          guard let results = response.valueForKey("results") as? [AnyObject] else { return }
          
          for result in results {
            if let result = result as? [String:AnyObject] {
              if let urls:NSURL = NSURL(string: result["artworkUrl100"] as! String) {
                completion(url: urls)
              }
            } else {
              print("failed")
            }
          }
          
        }
        else {
          debugPrint("HTTP Request failed: \(response.result.error)")
        }
    }
  }
  
}

