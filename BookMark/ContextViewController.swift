//
//  ContextViewController.swift
//  WhaleTalk
//
//  Created by Joshua Kuehn on 5/18/16.
//  Copyright © 2016 Kuehn LLC. All rights reserved.
//

import Foundation
import CoreData

protocol ContextViewController {
  var context: NSManagedObjectContext? {get set}
}