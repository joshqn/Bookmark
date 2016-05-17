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
  private let tableView = UITableView(frame: CGRect.zero,style: .Grouped)
  private let cellIdentifier = "BookMarkCell"
  private var fetchedResultsDelegate: NSFetchedResultsControllerDelegate?
  private let cellHeight:CGFloat = 80

    override func viewDidLoad() {
        super.viewDidLoad()
      
      title = "Book Marks"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addBarButtonItemPressed(_:)))
      navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: StyleKit.imageOfSettingsButtonImage, style: .Plain, target: self, action: #selector(settingsButtonTapped(_:)))
      
      automaticallyAdjustsScrollViewInsets = false
      
      
      
      tableView.registerClass(BookMarksTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
      
      tableView.dataSource = self
      tableView.delegate = self
      tableView.rowHeight = cellHeight
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
  
  func addBarButtonItemPressed(button: UIBarButtonItem) {
    let newBooksVC = NewBookMarkViewController()
    newBooksVC.delegate = self
    newBooksVC.context = context
    let navVC = UINavigationController(rootViewController: newBooksVC)
    presentViewController(navVC, animated: true, completion: nil)
  }
  
  func settingsButtonTapped(button: UIBarButtonItem) {
    let settingsVC = SettingsViewController()
    settingsVC.context = context
    let navVC = UINavigationController(rootViewController: settingsVC)
    presentViewController(navVC, animated: true, completion: nil)
  }
  
  func configureCell(cell:UITableViewCell, atIndexPath:NSIndexPath) {
    let cell = cell as! BookMarksTableViewCell
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .MediumStyle
    dateFormatter.timeStyle = .NoStyle
    guard let bookMark = fetchedResultsController?.objectAtIndexPath(atIndexPath) as? BookMark else { return }
    
    cell.nameLabel.text = bookMark.name ?? "Nil"
    cell.pageLabel.text = bookMark.pageNumberAsText
    cell.dateLabel.text = dateFormatter.stringFromDate(bookMark.lastBookMarkDate ?? NSDate())
    
    if bookMark.photoData == nil {
      cell.bookArtwork.image = StyleKit.imageOfCanvas1
      cell.bookArtwork.layer.borderColor = UIColor.clearColor().CGColor
    } else {
      cell.bookArtwork.image = bookMark.bookImage
      cell.bookArtwork.layer.shadowRadius = 4.0
      cell.bookArtwork.layer.shadowOpacity = 0.5
      cell.bookArtwork.layer.shadowOffset = CGSize.zero
    }
  }

}

extension BookMarksViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let bookMark = fetchedResultsController?.objectAtIndexPath(indexPath) as? BookMark else { return }
    let newBooksVC = NewBookMarkViewController()
    newBooksVC.delegate = self
    newBooksVC.context = context
    newBooksVC.bookmark = bookMark
    let navVC = UINavigationController(rootViewController: newBooksVC)
    let navBar = navVC.navigationBar
    presentViewController(navVC, animated: true, completion: nil)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      guard let bookMark = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? BookMark, let context = self.context else { return }
      context.deleteObject(bookMark)
      do {
        try context.save()
      } catch {
        print("Could not delete BookMark")
      }
      
    })
    delete.backgroundColor = UIColor.redColor()
    
    let more = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Archive" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      //Do something
    })
    more.backgroundColor = UIColor(red: 255/255, green: 207/255, blue: 51/255, alpha: 1.0)
    
    return [delete, more]
  }
}

extension BookMarksViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellHeight
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = fetchedResultsController?.sections else { return 0 }
    let currentSection = sections[section]
    return currentSection.numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BookMarksTableViewCell
    configureCell(cell, atIndexPath: indexPath)
    
    return cell 
  }

}

extension BookMarksViewController: NewBookMarkCreationDelegate {
  func newBookCreated(view: NewBookMarkViewController) {
    tableView.reloadData()
  }
}










