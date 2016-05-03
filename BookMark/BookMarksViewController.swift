//
//  BookMarksViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData

class BookMarksViewController: UIViewController {
  
  var context: NSManagedObjectContext?
  private var fetchedResultsController:NSFetchedResultsController?
  private let tableView = UITableView(frame: CGRect.zero,style: .Plain)
  private let cellIdentifier = "BookMarkCell"
  private var fetchedResultsDelegate: NSFetchedResultsControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      title = "Book Marks"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addBarButtonItemPressed(_:)))
      
      //Set to true later to see difference
      automaticallyAdjustsScrollViewInsets = false
      
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      tableView.dataSource = self
      tableView.delegate = self
      fillViewWith(tableView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func addBarButtonItemPressed(buttion: UIBarButtonItem) {
    let newBooksVC = NewBookMarkViewController()
    let bookContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    bookContext.parentContext = context
    newBooksVC.context = bookContext
    let navVC = UINavigationController(rootViewController: newBooksVC)
    presentViewController(navVC, animated: true, completion: nil)
  }
  
  func configureCell(cell:UITableViewCell, atIndexPath:NSIndexPath) {
    
  }

}

extension BookMarksViewController: UITableViewDelegate {
  
}

extension BookMarksViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

    return cell 
  }
}
