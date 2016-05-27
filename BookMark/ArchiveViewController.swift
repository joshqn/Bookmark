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
  private let cellHeight:CGFloat = 60
  
  private let dateFormatter = NSDateFormatter()
  
  private var fetchedResultsController: NSFetchedResultsController?
  private var fetchedResultsDelegate: NSFetchedResultsControllerDelegate?
  
  lazy var isArchivedPredicate: NSPredicate = {
    var predicate = NSPredicate(format: "isArchived == true")
    return predicate
  }()
  let authorSort = NSSortDescriptor(key: "author", ascending: true)

    override func viewDidLoad() {
        super.viewDidLoad()
      
      navigationController?.navigationBar.topItem?.title = "Archive"
      automaticallyAdjustsScrollViewInsets = false
      tableView.rowHeight = cellHeight
      tableView.registerClass(ArchiveTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      tableView.dataSource = self
      tableView.delegate = self
      
      fillViewWith(tableView)
      
      dateFormatter.dateStyle = .MediumStyle
      dateFormatter.timeStyle = .NoStyle
      
      if let context = context {
        let request = NSFetchRequest(entityName: "BookMark")
        request.predicate = isArchivedPredicate
        request.sortDescriptors = [authorSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "author", cacheName: nil)
        
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
  
  func configureCell(cell: UITableViewCell, atIndexPath: NSIndexPath) {
    let cell = cell as! ArchiveTableViewCell
    guard let bookMark = fetchedResultsController?.objectAtIndexPath(atIndexPath) as? BookMark else { return }
    cell.bookName.text = bookMark.name ?? "Nil"
    cell.artwork.image = bookMark.bookImage
    cell.statusImage.image = bookMark.isFinished == true ? StyleKit.imageOfBookmarkFinished : StyleKit.imageOfBookmarkPaused
    cell.archivedDate.text = dateFormatter.stringFromDate(bookMark.archivedDate ?? NSDate())
  }

}

extension ArchiveViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = fetchedResultsController?.sections else { return 0 }
    let currentSection = sections[section]
    return currentSection.numberOfObjects
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return fetchedResultsController?.sections!.count ?? 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ArchiveTableViewCell
    configureCell(cell, atIndexPath: indexPath)
    
    return cell
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let sectionInfo = fetchedResultsController?.sections![section]
    return sectionInfo?.name
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellHeight
  }
  
}

extension ArchiveViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      guard let bookMark = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? BookMark, let context = self.context else { return }
      context.deleteObject(bookMark)
      do {
        try context.save()
      } catch {
        print("Could not delete BookMark")
      }
      
    })
    
    let more = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Unarchive" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      guard let context = self.context, let bookMark = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? BookMark else {return}
      bookMark.isArchived = false
      bookMark.isFinished = false
      do {
        try context.save()
      } catch {
        print("ERROR: Couldn't update archived status")
      }
      
    })
    more.backgroundColor = UIColor(red: 255/255, green: 207/255, blue: 51/255, alpha: 1.0)
    
    return [delete, more]
  }
}