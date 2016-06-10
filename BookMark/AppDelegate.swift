//
//  AppDelegate.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData

let isSortedByAuthorKey = "isSortedByAuthor"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    
    if NSUserDefaults.isFirstLaunch() {
      //The default for sorting in the archive is by Author Name
      NSUserDefaults.standardUserDefaults().setBool(true, forKey: isSortedByAuthorKey)
    }
    
    let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = CDHelper.sharedInstance.coordinator
    
    let tabController = UITabBarController()
    let vcData: [(UIViewController,UIImage,UIImage, String)] = [
      (BookMarksViewController(), StyleKit.imageOfTabBarBMImageFlat, StyleKit.imageOfTabBarBMSelectedBMImage, "Bookmarks"),
      (ArchiveViewController(),StyleKit.imageOfTabBarArchiveImageFlat, StyleKit.imageOfTabBarArchiveSelectedImage, "Archive")
    ]
    
    let vcs = vcData.map { (vc: UIViewController, image: UIImage, selectedImage: UIImage, title: String) -> UINavigationController in
      if var vc = vc as? ContextViewController {
        vc.context = context
      }
      let nav = UINavigationController(rootViewController: vc)
      nav.navigationBar.tintColor = UIColor.darkGrayColor()
      
      nav.tabBarItem.image = image
      nav.tabBarItem.selectedImage = selectedImage
      nav.title = title
      return nav
    }
    
    tabController.viewControllers = vcs
    tabController.tabBar.tintColor = StyleKit.mainTintColor
    window?.rootViewController = tabController
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

