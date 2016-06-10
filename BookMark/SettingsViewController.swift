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
  var prefs = NSUserDefaults.standardUserDefaults()


    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = UIColor.whiteColor()
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))
      
      navigationController?.navigationBar.topItem?.title = "Settings"
      
      automaticallyAdjustsScrollViewInsets = false
      
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

      tableView.dataSource = self
      tableView.delegate = self
      fillViewWith(tableView)
      
      
      
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
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch indexPath.section {
    //Section 1
    case 0:
      if indexPath.row == 0 {
        let sortVC = SortViewController()
        sortVC.delegate = self
        let navVC = UINavigationController(rootViewController: sortVC)
        presentViewController(navVC, animated: true, completion: nil)
      }
      
    default:
      break
    }
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

extension SettingsViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Archive"
    }
    
    return nil
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
      //Archive
    case 0:
      return 1
      //Help Section
    case 1:
      return 2
    default:
      break
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
    
    configureCell(cell, atIndexPath: indexPath)
    
    switch indexPath.section {
      
    //Section 1
    case 0:
      switch indexPath.row {
      //Cell 0
      case 0:
        
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = "Sort"

        if prefs.boolForKey(isSortedByAuthorKey) {
          cell.detailTextLabel?.text = "Author"
        } else {
          cell.detailTextLabel?.text = "Book"
        }
        
      default:
        print("Settings TBV cellForRowAtIndexPath Default")
      }

      //Section 2
    case 1:
      switch indexPath.row {
        //Cell 0
      case 0:
        cell.textLabel?.text = "Help"
        //Cell 1
      case 1:
        cell.textLabel?.text = "About PageLead"
      default:
        print("Settings TBV cellForRowAtIndexPath Default")
      }
      
    default:
      print("Settings TBV cellForRowAtIndexPath Default Section")

    }
    
    
    return cell
  }
}

extension SettingsViewController: SortViewControllerDelegate {
  func didDismissSortView(view: UIViewController) {
    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
}


























