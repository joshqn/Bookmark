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
    
    private var bookImageViews:[BookMarkArtIV] = []
    private var superController: UIViewController?
    private var numberOfImages = 0
    private var isCurrentlyVisible = false
    var bottomConstraint:NSLayoutConstraint!
  var scrollView:UIScrollView?
  
    init(superController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.superController = superController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.view.layer.shadowOffset = CGSizeZero
      self.view.layer.shadowRadius = 4.0
      self.view.layer.shadowOpacity = 0.7
      
      
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.superController?.view.addSubview(self.view)
        
        bottomConstraint = self.view.bottomAnchor.constraintEqualToAnchor(self.superController?.view.bottomAnchor)
        bottomConstraint.priority = 250
        
        scrollView = UIScrollView(frame: self.view.bounds)
      
        guard let scrollView = scrollView else { return }
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(scrollView)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapped))
        scrollView.addGestureRecognizer(tapGesture)
        
      numberOfImages = (dataSource?.numberOfImagesToDisplay(scrollView))!
      scrollView.contentSize.width = (20 + (78 * CGFloat(numberOfImages)))
        
      for _ in 1...numberOfImages {
        let bookImageView = BookMarkArtIV()
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
        self.view.widthAnchor.constraintEqualToAnchor(superController!.view.widthAnchor),
        //The image is 80 so I gave it a 20 point top and bottom margin here
        self.view.heightAnchor.constraintEqualToConstant(120),
        ]
      
      var i:CGFloat = 0
      for bookImageView in bookImageViews {
        bookImageView.delegate = self
        //The leading anchor is built with a 20 point margin between each view and it's left side and right
        bookImageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor,constant: 20 + (78 * i)).active = true
        bookImageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor,constant: 20).active = true
        bookImageView.heightAnchor.constraintEqualToConstant(80).active = true
        bookImageView.widthAnchor.constraintEqualToConstant(58).active = true
        i = i + 1
      }
        
        NSLayoutConstraint.activateConstraints(constraints)
        
    }
  
  func reloadImageViews() {
    guard let scrollView = scrollView else { return }
    delegate?.setImageAtIndex(self, scrollView: scrollView, images: bookImageViews)
  }
    
    func tapped() {
        print("ScrollViewTapped")
        self.view.endEditing(true)
    
    }
    
    func keyboardWillShow(notification:NSNotification) {
        if let userInfo = notification.userInfo, frame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
            let newFrame = view.convertRect(frame, fromView: (UIApplication.sharedApplication().delegate?.window)!)
            bottomConstraint.constant = 0
            bottomConstraint.constant -= newFrame.height
            bottomConstraint.active = true
            delegate?.bookmarkImagePickerDidAppear(self)
            UIView.animateWithDuration(animationDuration, animations: {
                self.superController?.view.layoutIfNeeded()
                
            })
        }
        
    }
    
    func keyboardWillHide(notification:NSNotification) {
        if let userInfo = notification.userInfo, frame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
            let newFrame = view.convertRect(frame, fromView: (UIApplication.sharedApplication().delegate?.window)!)
            bottomConstraint.constant += newFrame.height
            self.bottomConstraint.active = false
            delegate?.bookmarkImagePickerDidDisappear(self)
            UIView.animateWithDuration(animationDuration, animations: {
                self.superController?.view.layoutIfNeeded()
                }, completion: { completed in
              })
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func turnOnNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    print("Deinit")
  }
  
}

protocol BookmarkImagePickerDelegate: class {
    var topAnchor: NSLayoutConstraint? { get set }
    func setImageAtIndex(view: BookmarkImagePickerVC, scrollView: UIScrollView, images: [BookMarkArtIV])
    func bookmarkImagePickerDidAppear(picker: BookmarkImagePickerVC)
    func bookmarkImagePickerDidDisappear(picker: BookmarkImagePickerVC)
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










