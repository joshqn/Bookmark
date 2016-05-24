//
//  ArchiveViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/24/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData

class ArchiveViewController: UIViewController, ContextViewController, TableViewFetchedResultsDisplayer {
  
  var context: NSManagedObjectContext?
  private let tableView = UITableView(frame: CGRect.zero, style: .Grouped)
  private let cellIdentifier = "ArchiveCell"
  
  private var fetchedResultsController: NSFetchedResultsController?
  private var fetchedResultsDelegate: NSFetchedResultsControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      navigationController?.navigationBar.topItem?.title = "Archive"
      automaticallyAdjustsScrollViewInsets = false
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      tableView.dataSource = self
      tableView.delegate = self
      
      fillViewWith(tableView)
      
      if let context = context {
        
      }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func configureCell(cell: UITableViewCell, atIndexPath: NSIndexPath) {
    //Code
  }

}

extension ArchiveViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    return cell
  }
  
}

extension ArchiveViewController: UITableViewDelegate {
  
}