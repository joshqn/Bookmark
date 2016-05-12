//
//  NewBookMarkViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

protocol NewBookMarkCreationDelegate:class {
  func newBookCreated(view: NewBookMarkViewController)
}

class NewBookMarkViewController: UIViewController {

  var context: NSManagedObjectContext?
  weak var delegate: NewBookMarkCreationDelegate?
  
  var bookmark: BookMark?
  
  private let bookNameTextField = UITextField()
  private let pageTextField = UITextField()
  
  private let bookNameLabel = UILabel()
  private let pageLabel = UILabel()
  
  private let bookBottomBorder = UIView()
  private let pageBottomBorder = UIView()

  private let addPhotoButton = UIButton(type: UIButtonType.System)
  private var artworkImage = BookMarkArtIV()
  
  var i = 0
  
  var bookMarkImagePickerVC: BookmarkImagePickerVC?
  
  var topAnchor: NSLayoutConstraint?
    
  var searchBar: UISearchBar!
  var searchBarConstraints: [NSLayoutConstraint]!
  var searchBarBottomConstraint: NSLayoutConstraint!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = UIColor.whiteColor()
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancel))
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))

      automaticallyAdjustsScrollViewInsets = false
      
      let tapGesture = UITapGestureRecognizer()
      tapGesture.addTarget(self, action: #selector(viewTapped))
      view.addGestureRecognizer(tapGesture)
      
      if bookmark == nil {
        title = "New Book Mark"
        artworkImage.image = StyleKit.imageOfBmArtPlaceHolder
        bookNameTextField.becomeFirstResponder()
        updateDoneButton(forCharCount: 0)
        
      } else {
        title = "Edit Book"
        guard let bookMark = bookmark else { return }
        bookNameTextField.text = bookmark!.name
        guard let pageNumber = bookmark?.page else { return }
        pageTextField.text = "\(pageNumber)"
        guard let photoData = bookMark.photoData else { return }
        artworkImage.image = UIImage(data: photoData)
        self.artworkImage.layer.shadowRadius = 4.0
        self.artworkImage.layer.shadowOffset = CGSize.zero
        self.artworkImage.layer.shadowOpacity = 0.5
        self.artworkImage.layer.borderColor = UIColor.blackColor().CGColor
        self.artworkImage.layer.borderWidth = 1.0
        updateDoneButton(forCharCount: 1)
        pageTextField.becomeFirstResponder()
        
      }
      
      createUI()
      createAndAddConstraints()
      self.view.layoutSubviews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  //MARK: Helpers
  
  func createUI() {
    bookNameLabel.text = "Book"
    bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bookNameLabel)
    
    pageLabel.text = "Page"
    pageLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pageLabel)
    
    bookNameTextField.placeholder = "Book Name"
    bookNameTextField.translatesAutoresizingMaskIntoConstraints = false
    bookNameTextField.delegate = self
    view.addSubview(bookNameTextField)
    
    pageTextField.placeholder = "Current Page"
    pageTextField.translatesAutoresizingMaskIntoConstraints = false
    pageTextField.keyboardType = UIKeyboardType.NumberPad
    pageTextField.delegate = self
    view.addSubview(pageTextField)
    
    bookBottomBorder.backgroundColor = UIColor.lightGrayColor()
    bookBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    bookNameTextField.addSubview(bookBottomBorder)
    
    pageBottomBorder.backgroundColor = UIColor.lightGrayColor()
    pageBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    pageTextField.addSubview(pageBottomBorder)
    
    bookNameTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    pageTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    
    addPhotoButton.setTitle("Edit", forState: .Normal)
    addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
    addPhotoButton.addTarget(self, action: #selector(addButtonTapped(_:)), forControlEvents: .TouchUpInside)
    view.addSubview(addPhotoButton)
    
    artworkImage.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(artworkImage)
    
    bookMarkImagePickerVC = BookmarkImagePickerVC(superController: self)
    bookMarkImagePickerVC?.turnOnNotifications()
    self.bookMarkImagePickerVC?.delegate = self
    self.bookMarkImagePickerVC?.dataSource = self
    
    searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(searchBar)
    searchBar.delegate = self
    searchBarBottomConstraint = searchBar.bottomAnchor.constraintEqualToAnchor(self.view.topAnchor)
    searchBarBottomConstraint.priority = 249
    searchBarBottomConstraint.active = true
    searchBarConstraints = [
      searchBar.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor),
      searchBar.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor),
      searchBar.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor),
    ]
  }
  
  func createAndAddConstraints() {
    
    self.topAnchor = self.bookMarkImagePickerVC?.view.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor,constant: 0)
    
    if let topAnchor = topAnchor {
      topAnchor.priority = 999
      topAnchor.active = true
    }
    
    let constraints: [NSLayoutConstraint] = [
    bookNameLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor,constant: 30),
    bookNameLabel.leadingAnchor.constraintEqualToAnchor(artworkImage.trailingAnchor,constant: 10),
    
    pageLabel.topAnchor.constraintEqualToAnchor(bookNameLabel.bottomAnchor, constant: 15),
    pageLabel.leadingAnchor.constraintEqualToAnchor(bookNameLabel.leadingAnchor),
    
    bookNameTextField.centerYAnchor.constraintEqualToAnchor(bookNameLabel.centerYAnchor),
    bookNameTextField.leadingAnchor.constraintEqualToAnchor(bookNameLabel.trailingAnchor, constant: 15),
    bookNameTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    bookBottomBorder.widthAnchor.constraintEqualToAnchor(bookNameTextField.widthAnchor),
    bookBottomBorder.bottomAnchor.constraintEqualToAnchor(bookNameTextField.bottomAnchor),
    bookBottomBorder.leadingAnchor.constraintEqualToAnchor(bookNameTextField.leadingAnchor),
    bookBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    pageTextField.centerYAnchor.constraintEqualToAnchor(pageLabel.centerYAnchor),
    pageTextField.leadingAnchor.constraintEqualToAnchor(pageLabel.trailingAnchor, constant: 15),
    pageTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    pageBottomBorder.widthAnchor.constraintEqualToAnchor(pageTextField.widthAnchor),
    pageBottomBorder.bottomAnchor.constraintEqualToAnchor(pageTextField.bottomAnchor),
    pageBottomBorder.leadingAnchor.constraintEqualToAnchor(pageTextField.leadingAnchor),
    pageBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    addPhotoButton.topAnchor.constraintEqualToAnchor(artworkImage.bottomAnchor,constant: 5),
    addPhotoButton.centerXAnchor.constraintEqualToAnchor(artworkImage.centerXAnchor),
    
    artworkImage.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 20),
    artworkImage.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor),
    artworkImage.heightAnchor.constraintEqualToConstant(80),
    artworkImage.widthAnchor.constraintEqualToConstant(58),
    
    searchBar.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor)
    ]
    
    NSLayoutConstraint.activateConstraints(constraints)

  }
  
  //Updates the Done buttons appear according to if the length of characters in the book name text field is greater than 0
  func updateDoneButton(forCharCount length: Int) {
    if length == 0 {
      navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGrayColor()
      navigationItem.rightBarButtonItem?.enabled = false
      addPhotoButton.enabled = false
    } else {
      navigationItem.rightBarButtonItem?.tintColor = view.tintColor
      navigationItem.rightBarButtonItem?.enabled = true
      addPhotoButton.enabled = true 
    }
  }
  
  //MARK: Actions
  
  func viewTapped() {
    view.endEditing(true)
    topAnchor?.priority = 999
  }
  
  func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func done() {
    if bookmark != nil {
      guard let context = context, let bookmark = bookmark else { return }
      if artworkImage.image == StyleKit.imageOfBmArtPlaceHolder {
        bookmark.photoData = nil
      } else {
        let photoData = UIImagePNGRepresentation(artworkImage.image!)
        bookmark.photoData = photoData
      }
      bookmark.name = bookNameTextField.text!
      bookmark.page = Int(pageTextField.text ?? "0")
      bookmark.lastBookMarkDate = NSDate()
      
      do {
        try context.save()
      } catch {
        print("Error saving")
      }
      
      delegate?.newBookCreated(self)
      dismissViewControllerAnimated(true, completion: nil)
    } else {
      guard let context = context, let bookMark = NSEntityDescription.insertNewObjectForEntityForName("BookMark", inManagedObjectContext: context) as? BookMark else { return }
      
      //I'm checking to see if a different image than the default was selected. If not It's set to nil so that the different default image in the main VC is used and not this one.
      if artworkImage.image == StyleKit.imageOfBmArtPlaceHolder {
        bookMark.photoData = nil
      } else {
        let photoData = UIImagePNGRepresentation(artworkImage.image!)
        bookMark.photoData = photoData
      }
      bookMark.name = bookNameTextField.text!
      bookMark.page = Int(pageTextField.text ?? "0")
      bookMark.lastBookMarkDate = NSDate()
      
      do {
        try context.save()
      } catch {
        print("Error saving")
      }
      
      delegate?.newBookCreated(self)
      dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
  }
  
  func addButtonTapped(button: UIButton) {
    topAnchor?.priority = 249
    bookMarkImagePickerVC?.turnOnNotifications()
    bookMarkImagePickerVC?.reloadImageViews()
    i = 0
    
    let optionMenu = UIAlertController(title: "Edit Photo", message: "Take a Picture or Search for One", preferredStyle: .ActionSheet)
    let searchAction = UIAlertAction(title: "Search", style: .Default) { (action) in
      NSLayoutConstraint.activateConstraints(self.searchBarConstraints)
      self.searchBar.text = self.bookNameTextField.text
      UIView.animateWithDuration(0.33, animations: {
        self.view.layoutIfNeeded()
        }, completion: {
          completed in
          self.searchBar.becomeFirstResponder()
      })
      
    }
    
    let takePhotoAction = UIAlertAction(title: "Photo", style: .Default) { (action) in
      print("Take Photo")
    }
    
    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    
    optionMenu.addAction(searchAction)
    optionMenu.addAction(takePhotoAction)
    optionMenu.addAction(cancelButton)
    
    self.presentViewController(optionMenu, animated: true, completion: nil)
    
  }

}

extension NewBookMarkViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool  {
    let currentCharCount = textField.text?.characters.count ?? 0
    let newLength = currentCharCount + string.characters.count - range.length
    updateDoneButton(forCharCount: newLength)
    
    return true
  }
}


extension NewBookMarkViewController: BookmarkImagePickerDelegate {
  
  func bookmarkImagePickerDidAppear(view: BookmarkImagePickerVC) {
    UIView.animateWithDuration(0.33, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  func bookmarkImagePickerDidDisappear(view: BookmarkImagePickerVC) {
    NSLayoutConstraint.deactivateConstraints(searchBarConstraints)
    UIView.animateWithDuration(0.33, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  func setImageAtIndex(view: BookmarkImagePickerVC, scrollView: UIScrollView, images: [BookMarkArtIV]) {
    guard let textField = bookNameTextField.isFirstResponder() || pageTextField.isFirstResponder() == true ? bookNameTextField.text : searchBar.text else { return }
    i = 0
    Search.sendMyApiRequest(textField) { (url) in
      images[self.i].tag = self.i
      images[self.i].image = nil
      images[self.i].loadImageWithURL(url)
      self.i = self.i + 1
      
    }
  }
  
  func imageWasSelectedWithTag(view: BookMarkArtIVDelegate, image: BookMarkArtIV) {
    UIView.animateWithDuration(0.12, delay: 0.0, options: .CurveEaseOut, animations: {
     self.artworkImage.alpha = 0.0
      }, completion: { completed in
        UIView.animateWithDuration(0.2, animations: {
          self.artworkImage.image = image.image
          self.artworkImage.alpha = 1.0
          self.artworkImage.layer.shadowRadius = 4.0
          self.artworkImage.layer.shadowOffset = CGSize.zero
          self.artworkImage.layer.shadowOpacity = 0.5
          self.artworkImage.layer.borderColor = UIColor.blackColor().CGColor
          self.artworkImage.layer.borderWidth = 1.0
        })
    })
    
    self.view.endEditing(true)
    topAnchor?.priority = 999
  }
  
}

extension NewBookMarkViewController: BookmarkImagePickerDataSource {
  
  func numberOfImagesToDisplay(scrollView: UIScrollView) -> Int {
    return 8
  }
  
}

extension NewBookMarkViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    bookMarkImagePickerVC?.reloadImageViews()
  }
}


























