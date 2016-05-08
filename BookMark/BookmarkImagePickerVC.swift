//
//  BookmarkImagePickerVC.swift
//  BookMarkImageScrollView
//
//  Created by Joshua Kuehn on 5/4/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class BookmarkImagePickerVC: UIViewController {
  
  weak var delegate: BookmarkImagePickerDelegate?
  weak var dataSource: BookmarkImagePickerDataSource?
  
  var bookImageViews:[BookMarkArtIV] = []
  private var superController: UIViewController?
  private var numberOfImages = 0
  
  var scrollView = UIScrollView()
  
  var backgroundTint = UIView()
  let tapGesture = UITapGestureRecognizer()
  
  init(superController: UIViewController) {
    super.init(nibName: nil, bundle: nil)
    self.superController = superController
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      //This gesture is used to hide the bookMarkImagePickerVC
      tapGesture.addTarget(self, action: #selector(viewWasTapped))
      backgroundTint.addGestureRecognizer(tapGesture)
      
      backgroundTint.translatesAutoresizingMaskIntoConstraints = false
      backgroundTint.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
      backgroundTint.frame = superController!.view.bounds

      self.view.translatesAutoresizingMaskIntoConstraints = false 
      superController!.view.addSubview(self.view)
      
      scrollView = UIScrollView(frame: self.view.bounds)
      scrollView.indicatorStyle = .Black
      scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      scrollView.backgroundColor = UIColor.whiteColor()
      self.view.addSubview(scrollView)
      
      numberOfImages = (dataSource?.numberOfImagesToDisplay(scrollView))!
      scrollView.contentSize.width = (20 + (100 * CGFloat(numberOfImages)))

      for _ in 1...numberOfImages {
        let bookImageView = BookMarkArtIV()
        bookImageView.delegate = self
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.backgroundColor = UIColor.blueColor()
        bookImageView.layer.borderWidth = 1.0
        bookImageView.layer.borderColor = UIColor.blackColor().CGColor
        bookImageView.layer.shadowOffset = CGSize.zero
        bookImageView.layer.shadowOpacity = 0.5
        bookImageView.layer.shadowRadius = 4.0
        bookImageViews.append(bookImageView)
        scrollView.addSubview(bookImageView)
      }
      
      let constraints: [NSLayoutConstraint] = [
        self.view.centerXAnchor.constraintEqualToAnchor(superController!.view.centerXAnchor),
        self.view.widthAnchor.constraintEqualToAnchor(superController!.view.widthAnchor),
        //The image is 100 so I gave it a 20 point top and bottom margin here
        self.view.heightAnchor.constraintEqualToConstant(120),
      ]
      
      var i:CGFloat = 0
      for bookImageView in bookImageViews {
        //The leading anchor is built with a 20 point margin between each view and it's left side and right 
        bookImageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor,constant: 20 + (100 * i)).active = true
        bookImageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor,constant: 20).active = true
        bookImageView.heightAnchor.constraintEqualToConstant(80).active = true
        bookImageView.widthAnchor.constraintEqualToConstant(80).active = true
        i = i + 1
      }
            
      NSLayoutConstraint.activateConstraints(constraints)
      
      delegate?.setImageAtIndex(self, scrollView: scrollView, images: bookImageViews)
            
    }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func viewWasTapped() {
    delegate?.hideBookmarkImagePicker(self)
  }
  
  deinit {
    print("deinit")
  }

}

protocol BookmarkImagePickerDelegate: class {
  var topAnchor: NSLayoutConstraint { get set }
  func showBookmarkImagePicker(view:BookmarkImagePickerVC)
  func hideBookmarkImagePicker(view:BookmarkImagePickerVC)
  func setImageAtIndex(view: BookmarkImagePickerVC, scrollView: UIScrollView, images: [BookMarkArtIV])
  func imageWasSelectedWithTag(view: BookMarkArtIVDelegate, image: BookMarkArtIV)
}

protocol BookmarkImagePickerDataSource: class {
  func numberOfImagesToDisplay(scrollView: UIScrollView) -> Int
}

extension BookmarkImagePickerVC: BookMarkArtIVDelegate {
  func bookMarkArtIVWasSelected(view: BookMarkArtIV) {
    delegate?.imageWasSelectedWithTag(self, image: view)
  }
}







