//
//  BookMark+CoreDataProperties.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/5/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BookMark {

    @NSManaged var lastBookMarkDate: NSDate?
    @NSManaged var name: String?
    @NSManaged var page: NSNumber?
    @NSManaged var photoData: NSData?

}
