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
    
    private var bookImageViews:[BookMarkArtIV] = []
    private var superController: UIViewController?
    private var numberOfImages = 0
    private var isCurrentlyVisible = false
    var bottomConstraint:NSLayoutConstraint!
    var scrollView:UIScrollView?
  
  let search = Search()
  
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
      
      let constraints: [NSLayoutConstraint] = [
        self.view.widthAnchor.constraintEqualToAnchor(superController!.view.widthAnchor),
        self.view.heightAnchor.constraintEqualToConstant(120),
        ]
      
        NSLayoutConstraint.activateConstraints(constraints)
        
    }
  
  func performSearchWithText(text:String) {
    guard let scrollView = scrollView else { return }
    scrollView.subviews.forEach({ $0.removeFromSuperview() })
    
    var spinner = UIActivityIndicatorView()
    spinner = showSpinner(scrollView)
    
    search.performSearchForText(text) { success in
      guard success != false else {
        spinner.stopAnimating()
  
        return
      }
      spinner.stopAnimating()
      self.reloadImageViews()
    }
  }
  
  func loadImageViewIndex(scrollView:UIScrollView, viewWithIndex index: Int) {
    let imageView = BookMarkArtIV()
    imageView.backgroundColor = UIColor.whiteColor()
    imageView.delegate = self
    imageView.tag = index
    switch search.state {
    case .Results(let list):
      scrollView.addSubview(imageView)
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor, constant: 20 + (78 * CGFloat(index))).active = true
      imageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor,constant: 20).active = true
      imageView.heightAnchor.constraintEqualToConstant(80).active = true
      imageView.widthAnchor.constraintEqualToConstant(58).active = true
      
      let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
      spinner.translatesAutoresizingMaskIntoConstraints = false
      imageView.addSubview(spinner)
      spinner.centerXAnchor.constraintEqualToAnchor(imageView.centerXAnchor).active = true
      spinner.centerYAnchor.constraintEqualToAnchor(imageView.centerYAnchor).active = true
      spinner.tag = 1000
      spinner.startAnimating()
      
      search.downloadImageWithUrl(list[index].0) { success in
        guard success != false else {
          print("Couldn't download Images")
          return
        }
        imageView.viewWithTag(1000)?.removeFromSuperview()
        
        
        switch self.search.imageRequestState {
        case .Results(let image):
          imageView.image = image
        default:
          print("Shouldn't get here")
        }
        
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 4.0
        
        self.bookImageViews.append(imageView)
      }
      
    default:
      print("Default")
      break
    }
    
    
  }
  
  func reloadImageViews() {
    guard let scrollView = scrollView else { return }
    
    switch search.state {
    case .NoResults:
      print("No Results")
    case .Results(let list):
      numberOfImages = list.count
      scrollView.contentSize.width = (20 + (78 * CGFloat(numberOfImages)))
      
      for i in 0...numberOfImages - 1 {
        loadImageViewIndex(scrollView, viewWithIndex: i)
        
      }
      
    default:
      print("Either Loading or not Searched yet")
    }
  }
  
  private func showSpinner(view: UIView) -> UIActivityIndicatorView {
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    spinner.center = CGPoint(x: CGRectGetMidX(view.bounds) + 0.5, y: CGRectGetMidY(view.bounds) + 0.5)
    spinner.tag = 1000
    view.addSubview(spinner)
    spinner.startAnimating()
    
    return spinner
    
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
    //func setImageAtIndex(view: BookmarkImagePickerVC, scrollView: UIScrollView, images: [BookMarkArtIV])
    func bookmarkImagePickerDidAppear(picker: BookmarkImagePickerVC)
    func bookmarkImagePickerDidDisappear(picker: BookmarkImagePickerVC)
    func imageWasSelectedWithTag(view: BookmarkImagePickerVC, image: BookMarkArtIV)
}

extension BookmarkImagePickerVC: BookMarkArtIVDelegate {
  func bookMarkArtIVWasSelected(view: BookMarkArtIV) {
    delegate?.imageWasSelectedWithTag(self, image: view)
  }
}










