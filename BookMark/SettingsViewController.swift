//
//  SettingsViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/16/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController,TableViewFetchedResultsDisplayer {
  
  var context: NSManagedObjectContext?
  private var fetchedResultsController:NSFetchedResultsController?
  private let tableView = UITableView(frame: CGRect.zero,style: .Grouped)
  private let cellIdentifier = "cell"


    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = UIColor.whiteColor()
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancel))
      navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))
      navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
      
      automaticallyAdjustsScrollViewInsets = false
      
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

      tableView.dataSource = self
      tableView.delegate = self
      fillViewWith(tableView)
      
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let navBar = self.navigationController?.navigationBar
    
    navBar?.barStyle = .Black
    navBar?.barTintColor = StyleKit.mainTintColor
    navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor() ]
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func configureCell(cell: UITableViewCell, atIndexPath: NSIndexPath) {
    //code
  }
  
  func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func done() {
    dismissViewControllerAnimated(true, completion: nil)
  }

}

extension SettingsViewController: UITableViewDelegate {
  
}

extension SettingsViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    configureCell(cell, atIndexPath: indexPath)
    return cell
  }
}
