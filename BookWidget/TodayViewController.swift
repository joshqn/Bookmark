//
//  TodayViewController.swift
//  BookWidget
//
//  Created by Joshua Kuehn on 7/5/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var tableView: UITableView!
  
  var bookResults:[AnyObject] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.registerClass(TodayTBCell.self, forCellReuseIdentifier: "cell")
      tableView.delegate = self
      tableView.dataSource = self
      
      self.automaticallyAdjustsScrollViewInsets = false
      tableView.contentInset = UIEdgeInsetsZero
      tableView.backgroundColor = UIColor.clearColor()
      
      // This frame is used to remove the space the header and footer create on TBV's
      var frame = CGRectZero
      frame.size.height = 1
      
      //Zeroing out the space with frame
      tableView.tableHeaderView = UIView(frame: frame)
      tableView.tableFooterView = UIView(frame: frame)
      
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
      
      CDHelper.sharedInstance.fetchResults { (completion, results) in
        if completion {
          self.bookResults = results ?? []
          self.tableView.reloadData()
          self.preferredContentSize = self.tableView.contentSize
          completionHandler(NCUpdateResult.NewData)
        }
      }
      
      completionHandler(.NoData)
    }
  
  func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
  }
    
}

extension TodayViewController: UITableViewDelegate {
  
}

extension TodayViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookResults.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? TodayTBCell else {return UITableViewCell()}
    cell.nameLabel.text = bookResults[indexPath.row].valueForKey("name") as? String ?? ""
    cell.pageLabel.text = String(bookResults[indexPath.row].valueForKey("page") as? NSNumber ?? 0)
    
    return cell
  }
}








