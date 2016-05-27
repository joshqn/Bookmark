//
//  Search.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/7/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

typealias SearchComplete = (Bool) -> Void
typealias SearchResults = (NSURL,String,String)

class Search {
  
  enum State {
    case NotSearchedYet
    case Loading
    case NoResults
    case Results([SearchResults])
  }
  
  enum ImageRequestState {
    case NotSearchedYet
    case Loading
    case Results(UIImage)
  }
  
  private(set) var state: State = .NotSearchedYet
  private(set) var imageRequestState: ImageRequestState = .NotSearchedYet
  
  func performSearchForText(text: String, completion: SearchComplete) {
    guard !text.isEmpty else { return }
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    self.state = .Loading
    
    // Add URL parameters
    let urlParams = [
      "term":text,
      "limit":"8",
      "entity":"ebook",
      ]
    
    self.state = .NotSearchedYet
    var success = false
    
    Alamofire.request(.GET, "http://itunes.apple.com/search",parameters:  urlParams)
      .validate(statusCode: 200..<300)
      .responseJSON { response in
        if response.result.error == nil {
          guard let response = response.result.value as? NSDictionary else { return }
          guard let results = response.valueForKey("results") as? [AnyObject] else { return }
          
          if results.isEmpty {
            self.state = .NoResults
          } else {
            var searchResults = [SearchResults]()
            for result in results {
              guard let result = result as? [String:AnyObject] else { return }
              guard let url:NSURL = NSURL(string: result["artworkUrl100"] as! String) else { return }
              guard let artistName = result["artistName"] as? String else {return}
              guard let bookName = result["trackName"] as? String else {return}
              
              searchResults.append((url,artistName,bookName))
            }
            self.state = .Results(searchResults)
          }
          success = true
        } else {
          debugPrint("HTTP Request failed: \(response.result.error)")
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        completion(success)
    }
    
  }
  
  func downloadImageWithUrl(url:NSURL, completion: SearchComplete) {
    var success = false
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    self.imageRequestState = .Loading
    
    Alamofire.request(.GET, url)
      .validate(statusCode: 200..<300)
      .responseData { (response) in
        if response.result.error == nil {
          guard let data = response.data else { return }
          guard let image = UIImage(data: data) else { return }
          
          success = true
          self.imageRequestState = .Results(image)
        } else {
          debugPrint("Image Download Request failed: \(response.result.error)")
        }
      
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false 
      completion(success)
    }
    
  }
}



