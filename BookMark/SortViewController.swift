//
//  SortViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 6/9/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

protocol SortViewControllerDelegate: class {
  func didDismissSortView(view: UIViewController)
}

class SortViewController: UIViewController {
  
  let tableView = UITableView(frame: CGRectZero, style: .Grouped)
  private let cellIdentifier = "cell"
  var prefs = NSUserDefaults.standardUserDefaults()
  var isSortedByAuthor = NSUserDefaults.standardUserDefaults().boolForKey(isSortedByAuthorKey)
  weak var delegate:SortViewControllerDelegate?
  
  private let authorPath = NSIndexPath(forRow: 0, inSection: 0)
  private let bookPath = NSIndexPath(forRow: 1, inSection: 0)
  
  enum SortingState {
    case Author
    case Book
  }


    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.whiteColor()
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))
      navigationController?.navigationBar.topItem?.title = "Archive Sort"

      
      automaticallyAdjustsScrollViewInsets = false
      
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      
      tableView.delegate = self
      tableView.dataSource = self
      
      fillViewWith(tableView)
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func done() {
    prefs.setBool(isSortedByAuthor, forKey: isSortedByAuthorKey)
    prefs.synchronize()
    delegate?.didDismissSortView(self)
    dismissViewControllerAnimated(true, completion: nil)
  }

}

extension SortViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {return}
    if cell.accessoryType != .Checkmark {
      
      isSortedByAuthor = !isSortedByAuthor
      
      guard let authorCell = tableView.cellForRowAtIndexPath(authorPath) else {return}
      authorCell.accessoryType = isSortedByAuthor == true ? .Checkmark : .None

      guard let bookCell = tableView.cellForRowAtIndexPath(bookPath) else {return}
      bookCell.accessoryType = isSortedByAuthor == false ? .Checkmark : .None
    }
    
    tableView.reloadRowsAtIndexPaths([authorPath,bookPath], withRowAnimation: .Automatic)
    
  }
}

extension SortViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    switch indexPath.row {
    case 0:
      cell.textLabel?.text = "Author"
      cell.accessoryType = isSortedByAuthor == true ? .Checkmark : .None
    case 1:
      cell.textLabel?.text = "Book"
      cell.accessoryType = isSortedByAuthor == false ? .Checkmark : .None

    default:
      break
    }
    
    return cell
  }

}
