//
//  BookMarksViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData

class BookMarksViewController: UIViewController, TableViewFetchedResultsDisplayer {
  
  var context: NSManagedObjectContext?
  private var fetchedResultsController:NSFetchedResultsController?
  private let tableView = UITableView(frame: CGRect.zero,style: .Plain)
  private let cellIdentifier = "BookMarkCell"
  private var fetchedResultsDelegate: NSFetchedResultsControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      title = "Book Marks"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addBarButtonItemPressed(_:)))
      
      automaticallyAdjustsScrollViewInsets = false
      
      tableView.registerClass(BookMarksTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      tableView.dataSource = self
      tableView.delegate = self
      fillViewWith(tableView)
      
      if let context = context {
        let request = NSFetchRequest(entityName: "BookMark")
        request.sortDescriptors = []
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsDelegate = TableViewFetchedResultsDelegate(tableView: tableView, displayer: self)
        fetchedResultsController?.delegate = fetchedResultsDelegate
        
        do {
          try fetchedResultsController?.performFetch()
        } catch {
          print("There was a problem fetching")
        }
        
      }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func addBarButtonItemPressed(buttion: UIBarButtonItem) {
    let newBooksVC = NewBookMarkViewController()
    newBooksVC.delegate = self
    newBooksVC.context = context
    let navVC = UINavigationController(rootViewController: newBooksVC)
    presentViewController(navVC, animated: true, completion: nil)
  }
  
  func configureCell(cell:UITableViewCell, atIndexPath:NSIndexPath) {
    let cell = cell as! BookMarksTableViewCell
    guard let bookMark = fetchedResultsController?.objectAtIndexPath(atIndexPath) as? BookMark else { return }
    
    cell.nameLabel.text = bookMark.name ?? "Nil"
    cell.dateLabel.text = String(bookMark.page ?? 0)
  }

}

extension BookMarksViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let bookMark = fetchedResultsController?.objectAtIndexPath(indexPath) as? BookMark else { return }
    let editBookVC = EditBookMarkViewController()
    let navVC = UINavigationController(rootViewController: editBookVC)
    editBookVC.context = context
    editBookVC.bookMark = bookMark
    presentViewController(navVC, animated: true, completion: nil)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      
      guard let bookMark = fetchedResultsController?.objectAtIndexPath(indexPath) as? BookMark, let context = context else { return }
      context.deleteObject(bookMark)
      do {
        try context.save()
      } catch {
        print("Could not delete BookMark")
      }
      
    }
  }
}

extension BookMarksViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = fetchedResultsController?.sections else { return 0 }
    let currentSection = sections[section]
    return currentSection.numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    configureCell(cell, atIndexPath: indexPath)
    return cell 
  }
}

extension BookMarksViewController: NewBookMarkCreationDelegate {
  func newBookCreated(view: NewBookMarkViewController) {
    tableView.reloadData()
  }
}










