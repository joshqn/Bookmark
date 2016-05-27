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
  private let authorTextField = UITextField()
  
  private let bookNameLabel = UILabel()
  private let pageLabel = UILabel()
  private let authorLabel = UILabel()
  
  private let bookBottomBorder = UIView()
  private let pageBottomBorder = UIView()
  private let authorBottomBorder = UIView()

  private let addPhotoButton = UIButton(type: UIButtonType.System)
  private let editPhotoButton = UIButton(type: .System)
  private var artworkImage = UIImageView()
  
  private var artworkIsSelected:Bool {
    get {
      return self.artworkIsSelected
    }
    set {
      if newValue {
        addPhotoButton.hidden = true
        editPhotoButton.hidden = false
      } else {
        addPhotoButton.hidden = false
        editPhotoButton.hidden = true
      }
    }
  }
  
  var bookMarkImagePickerVC: BookmarkImagePickerVC?
  
  var topAnchor: NSLayoutConstraint?
    
  var searchBar: UISearchBar!
  var searchBarConstraints: [NSLayoutConstraint]!
  var searchBarBottomConstraint: NSLayoutConstraint!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = UIColor.whiteColor()
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancel))
      navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGrayColor()
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))

      automaticallyAdjustsScrollViewInsets = false
      
      let tapGesture = UITapGestureRecognizer()
      tapGesture.addTarget(self, action: #selector(viewTapped))
      view.addGestureRecognizer(tapGesture)
      
      let didTapOnImageArtwork = UITapGestureRecognizer()
      didTapOnImageArtwork.addTarget(self, action: #selector(EditButtonTapped(_:)))
      artworkImage.addGestureRecognizer(didTapOnImageArtwork)
      
      if bookmark == nil {
        title = "New Book Mark"
        artworkIsSelected = false
        artworkImage.image = StyleKit.imageOfBlankImageArtwork
        bookNameTextField.becomeFirstResponder()
        updateDoneButton(forCharCount: 0)
      } else {
        title = "Edit Book"
        guard let bookmark = bookmark else { return }
        artworkIsSelected = true
        bookNameTextField.text = bookmark.name
        authorTextField.text = bookmark.author
        pageTextField.text = bookmark.pageNumberAsText
        artworkImage.image = bookmark.bookImage
        updateDoneButton(forCharCount: 1)
        pageTextField.becomeFirstResponder()
        dressUpImageLayer(artworkImage.layer)
        
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
    
    authorLabel.text = "Author"
    authorLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(authorLabel)
    
    bookNameTextField.placeholder = "Book Name"
    bookNameTextField.translatesAutoresizingMaskIntoConstraints = false
    bookNameTextField.delegate = self
    view.addSubview(bookNameTextField)
    
    pageTextField.placeholder = "Current Page"
    pageTextField.translatesAutoresizingMaskIntoConstraints = false
    pageTextField.keyboardType = UIKeyboardType.NumberPad
    pageTextField.delegate = self
    view.addSubview(pageTextField)
    
    authorTextField.placeholder = "Author(s) Name"
    authorTextField.translatesAutoresizingMaskIntoConstraints = false
    authorTextField.delegate = self
    authorTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    view.addSubview(authorTextField)
    
    bookBottomBorder.backgroundColor = UIColor.lightGrayColor()
    bookBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    bookNameTextField.addSubview(bookBottomBorder)
    
    pageBottomBorder.backgroundColor = UIColor.lightGrayColor()
    pageBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    pageTextField.addSubview(pageBottomBorder)
    
    authorBottomBorder.backgroundColor = UIColor.lightGrayColor()
    authorBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    authorTextField.addSubview(authorBottomBorder)
    
    bookNameTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    pageTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    
    artworkImage.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(artworkImage)
    
    editPhotoButton.setTitle("Edit", forState: .Normal)
    editPhotoButton.translatesAutoresizingMaskIntoConstraints = false
    editPhotoButton.addTarget(self, action: #selector(EditButtonTapped(_:)), forControlEvents: .TouchUpInside)
    view.addSubview(editPhotoButton)
    
    addPhotoButton.setTitle("Add Photo", forState: .Normal)
    addPhotoButton.titleLabel?.numberOfLines = 0
    addPhotoButton.titleLabel?.textAlignment = .Center
    addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
    addPhotoButton.addTarget(self, action: #selector(EditButtonTapped(_:)), forControlEvents: .TouchUpInside)
    view.addSubview(addPhotoButton)
    
    bookMarkImagePickerVC = BookmarkImagePickerVC(superController: self)
    bookMarkImagePickerVC?.turnOnNotifications()
    self.bookMarkImagePickerVC?.delegate = self
    
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
    
    pageLabel.topAnchor.constraintEqualToAnchor(authorLabel.bottomAnchor, constant: 15),
    pageLabel.leadingAnchor.constraintEqualToAnchor(bookNameLabel.leadingAnchor),
    
    authorLabel.topAnchor.constraintEqualToAnchor(bookNameLabel.bottomAnchor, constant: 15),
    authorLabel.leadingAnchor.constraintEqualToAnchor(bookNameLabel.leadingAnchor),
    
    bookNameTextField.centerYAnchor.constraintEqualToAnchor(bookNameLabel.centerYAnchor),
    bookNameTextField.leadingAnchor.constraintEqualToAnchor(authorTextField.leadingAnchor),
    bookNameTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    bookBottomBorder.widthAnchor.constraintEqualToAnchor(bookNameTextField.widthAnchor),
    bookBottomBorder.bottomAnchor.constraintEqualToAnchor(bookNameTextField.bottomAnchor),
    bookBottomBorder.leadingAnchor.constraintEqualToAnchor(bookNameTextField.leadingAnchor),
    bookBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    pageTextField.centerYAnchor.constraintEqualToAnchor(pageLabel.centerYAnchor),
    pageTextField.leadingAnchor.constraintEqualToAnchor(authorTextField.leadingAnchor),
    pageTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    pageBottomBorder.widthAnchor.constraintEqualToAnchor(pageTextField.widthAnchor),
    pageBottomBorder.bottomAnchor.constraintEqualToAnchor(pageTextField.bottomAnchor),
    pageBottomBorder.leadingAnchor.constraintEqualToAnchor(pageTextField.leadingAnchor),
    pageBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    authorTextField.centerYAnchor.constraintEqualToAnchor(authorLabel.centerYAnchor),
    authorTextField.leadingAnchor.constraintEqualToAnchor(authorLabel.trailingAnchor, constant: 10),
    authorTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    authorBottomBorder.widthAnchor.constraintEqualToAnchor(authorTextField.widthAnchor),
    authorBottomBorder.bottomAnchor.constraintEqualToAnchor(authorTextField.bottomAnchor),
    authorBottomBorder.leadingAnchor.constraintEqualToAnchor(authorTextField.leadingAnchor),
    authorBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    addPhotoButton.topAnchor.constraintEqualToAnchor(artworkImage.topAnchor,constant: 10),
    addPhotoButton.leadingAnchor.constraintEqualToAnchor(artworkImage.leadingAnchor),
    addPhotoButton.trailingAnchor.constraintEqualToAnchor(artworkImage.trailingAnchor),
    
    editPhotoButton.topAnchor.constraintEqualToAnchor(artworkImage.bottomAnchor,constant: 5),
    editPhotoButton.centerXAnchor.constraintEqualToAnchor(artworkImage.centerXAnchor),
    
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
      navigationItem.rightBarButtonItem?.enabled = false
    } else {
      navigationItem.rightBarButtonItem?.enabled = true
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
    save(bookmark, context: context, artworkImage: artworkImage, delegate: delegate)
  }
  
  func save(bookmark: BookMark?, context: NSManagedObjectContext?, artworkImage: UIImageView, delegate: NewBookMarkCreationDelegate?) {
    guard let context = context, let delegate = delegate else { return }
    guard let bookmark = bookmark != nil ? bookmark : NSEntityDescription.insertNewObjectForEntityForName("BookMark", inManagedObjectContext: context) as? BookMark else { return }
    if artworkImage.image == StyleKit.imageOfCanvas1 {
      bookmark.photoData = nil
    } else {
      let photoData = UIImagePNGRepresentation(artworkImage.image!)
      bookmark.photoData = photoData
    }
    bookmark.name = bookNameTextField.text ?? " "
    bookmark.author = authorTextField.text ?? " "
    bookmark.page = Int(pageTextField.text ?? "0")
    bookmark.lastBookMarkDate = NSDate()
    
    do {
      try context.save()
    } catch {
      print("Error saving")
    }
    
    delegate.newBookCreated(self)
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func EditButtonTapped(button: UIButton) {
    
    bookMarkImagePickerVC?.turnOnNotifications()
    guard let textField = self.bookNameTextField.isFirstResponder() || self.pageTextField.isFirstResponder() == true ? self.bookNameTextField.text : self.searchBar.text else { return }
    
    if textField.characters.count > 0 {
      self.bookMarkImagePickerVC?.performSearchWithText(textField)
    }
    
    let optionMenu = UIAlertController(title: "Edit Photo", message: "Take a Picture or Search for One", preferredStyle: .ActionSheet)
    let searchAction = UIAlertAction(title: "Search", style: .Default) { (action) in
      self.topAnchor?.priority = 249
      self.bookMarkImagePickerVC?.turnOnNotifications()
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
    
    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
      self.topAnchor?.priority = 999
      print("Cancel")
    }
    
    optionMenu.addAction(searchAction)
    optionMenu.addAction(takePhotoAction)
    optionMenu.addAction(cancelButton)
    
    self.presentViewController(optionMenu, animated: true, completion: nil)
    
  }
  
  func dressUpImageLayer(layer: CALayer) {
    layer.borderColor = UIColor.blackColor().CGColor
    layer.borderWidth = 1.0
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
  
  func imageWasSelectedWithTag(view: BookmarkImagePickerVC, image: BookMarkArtIV) {
    
    switch view.search.state {
    case .Results(let list):
      let bookName = list[image.tag].2
      let authorName = list[image.tag].1
      self.bookNameTextField.text = bookName
      self.authorTextField.text = authorName
    default:
      print("Default")
    }
    
    UIView.animateWithDuration(0.12, delay: 0.0, options: .CurveEaseOut, animations: {
     self.artworkImage.alpha = 0.0
      
      self.artworkIsSelected = true
      }, completion: { completed in
        UIView.animateWithDuration(0.2, animations: {
          self.artworkImage.image = image.image
          self.artworkImage.alpha = 1.0
          self.dressUpImageLayer(self.artworkImage.layer)
          }, completion: { completed in
            
          })
    })
    
    self.view.endEditing(true)
    topAnchor?.priority = 999
  }
  
}

extension NewBookMarkViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    guard let textField = self.bookNameTextField.isFirstResponder() || self.pageTextField.isFirstResponder() == true ? self.bookNameTextField.text : self.searchBar.text else { return }
    self.bookMarkImagePickerVC?.performSearchWithText(textField)
  }
}


























