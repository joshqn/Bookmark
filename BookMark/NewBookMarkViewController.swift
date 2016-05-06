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
  
  var topAnchor: NSLayoutConstraint = NSLayoutConstraint()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = UIColor.whiteColor()
      title = "New Book Mark"
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancel))
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))

      automaticallyAdjustsScrollViewInsets = false
      
      let tapGesture = UITapGestureRecognizer()
      tapGesture.addTarget(self, action: #selector(viewTapped))
      view.addGestureRecognizer(tapGesture)
      
      createUI()
      createAndAddConstraints()
      bookNameTextField.becomeFirstResponder()

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
    updateDoneButton(forCharCount: 0)
    
    pageTextField.placeholder = "Current Page"
    pageTextField.translatesAutoresizingMaskIntoConstraints = false
    pageTextField.keyboardType = UIKeyboardType.NumberPad
    view.addSubview(pageTextField)
    
    bookBottomBorder.backgroundColor = UIColor.lightGrayColor()
    bookBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    bookNameTextField.addSubview(bookBottomBorder)
    
    pageBottomBorder.backgroundColor = UIColor.lightGrayColor()
    pageBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    pageTextField.addSubview(pageBottomBorder)
    
    bookNameTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    pageTextField.setContentHuggingPriority(249, forAxis: .Horizontal)
    
    addPhotoButton.setTitle("Add a Photo", forState: .Normal)
    addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
    addPhotoButton.addTarget(self, action: #selector(addButtonTapped(_:)), forControlEvents: .TouchUpInside)
    view.addSubview(addPhotoButton)
    
    artworkImage.translatesAutoresizingMaskIntoConstraints = false
    artworkImage.backgroundColor = UIColor.blueColor()
    view.addSubview(artworkImage)
  }
  
  func createAndAddConstraints() {
    let constraints: [NSLayoutConstraint] = [
    bookNameLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor,constant: 20),
    bookNameLabel.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor),
    
    pageLabel.topAnchor.constraintEqualToAnchor(bookNameLabel.bottomAnchor, constant: 15),
    pageLabel.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor),
    
    bookNameTextField.centerYAnchor.constraintEqualToAnchor(bookNameLabel.centerYAnchor),
    bookNameTextField.leadingAnchor.constraintEqualToAnchor(bookNameLabel.trailingAnchor, constant: 20),
    bookNameTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    bookBottomBorder.widthAnchor.constraintEqualToAnchor(bookNameTextField.widthAnchor),
    bookBottomBorder.bottomAnchor.constraintEqualToAnchor(bookNameTextField.bottomAnchor),
    bookBottomBorder.leadingAnchor.constraintEqualToAnchor(bookNameTextField.leadingAnchor),
    bookBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    pageTextField.centerYAnchor.constraintEqualToAnchor(pageLabel.centerYAnchor),
    pageTextField.leadingAnchor.constraintEqualToAnchor(pageLabel.trailingAnchor, constant: 20),
    pageTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20),
    pageBottomBorder.widthAnchor.constraintEqualToAnchor(pageTextField.widthAnchor),
    pageBottomBorder.bottomAnchor.constraintEqualToAnchor(pageTextField.bottomAnchor),
    pageBottomBorder.leadingAnchor.constraintEqualToAnchor(pageTextField.leadingAnchor),
    pageBottomBorder.heightAnchor.constraintEqualToConstant(1),
    
    addPhotoButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
    addPhotoButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
    
    artworkImage.topAnchor.constraintEqualToAnchor(addPhotoButton.bottomAnchor, constant: 20),
    artworkImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
    artworkImage.heightAnchor.constraintEqualToConstant(100),
    artworkImage.widthAnchor.constraintEqualToConstant(100)
    
    ]
    
    NSLayoutConstraint.activateConstraints(constraints)

  }
  
  //Updates the Done buttons appear according to if the length of characters in the book name text field is greater than 0
  func updateDoneButton(forCharCount length: Int) {
    if length == 0 {
      navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGrayColor()
      navigationItem.rightBarButtonItem?.enabled = false
    } else {
      navigationItem.rightBarButtonItem?.tintColor = view.tintColor
      navigationItem.rightBarButtonItem?.enabled = true
    }
  }
  
  func sendMyApiRequest(bookName:String, completion:(url:NSURL) -> Void) {
    
    // Add URL parameters
    let urlParams = [
      "term":bookName,
      "limit":"6",
      "entity":"ebook",
      ]
    
    // Fetch Request
    Alamofire.request(.GET, "http://itunes.apple.com/search", parameters: urlParams)
      .validate(statusCode: 200..<300)
      .responseJSON { response in
        if (response.result.error == nil) {
          guard let response = response.result.value as? NSDictionary else { return }
          guard let results = response.valueForKey("results") as? [AnyObject] else { return }
          
          for result in results {
            if let result = result as? [String:AnyObject] {
              if let urls:NSURL = NSURL(string: result["artworkUrl100"] as! String) {
                completion(url: urls)
              }
            } else {
              print("failed")
            }
          }
          
        }
        else {
          debugPrint("HTTP Request failed: \(response.result.error)")
        }
    }
  }
  
  //MARK: Actions
  
  func viewTapped() {
    view.endEditing(true)
  }
  
  func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func done() {
    guard let context = context, let bookMark = NSEntityDescription.insertNewObjectForEntityForName("BookMark", inManagedObjectContext: context) as? BookMark else { return }
    let photoData = UIImagePNGRepresentation(artworkImage.image!)
    bookMark.photoData = photoData
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
  
  func addButtonTapped(button: UIButton) {
    bookMarkImagePickerVC = BookmarkImagePickerVC(superController: self)
    bookMarkImagePickerVC?.delegate = self
    bookMarkImagePickerVC?.dataSource = self
    i = 0
    
    self.topAnchor = self.bookMarkImagePickerVC!.view.topAnchor.constraintEqualToAnchor(self.view.bottomAnchor,constant: 0)
    self.topAnchor.active = true
    
    view.endEditing(true)
    let optionMenu = UIAlertController(title: "Add a Photo", message: "Take a picture or Search for one", preferredStyle: .ActionSheet)
    let searchAction = UIAlertAction(title: "Search", style: .Default) { (action) in
      self.showBookmarkImagePicker(self.bookMarkImagePickerVC!)
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
  
  func showBookmarkImagePicker(view: BookmarkImagePickerVC) {
   self.view.addSubview(view.backgroundTint)
   self.view.insertSubview(view.backgroundTint, belowSubview: view.view)
    
    topAnchor.constant = -(120)
    
    UIView.animateWithDuration(0.33, animations: {
      self.view.layoutIfNeeded()
      self.navigationController?.navigationBarHidden = true
      view.backgroundTint.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    })
    
  }
  
  func hideBookmarkImagePicker(view: BookmarkImagePickerVC) {
    topAnchor.constant = 0
    
    UIView.animateWithDuration(0.5, animations: {
      self.view.layoutIfNeeded()
      self.navigationController?.navigationBarHidden = false

      view.backgroundTint.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    }) { (completed) in
      view.backgroundTint.removeFromSuperview()
      self.bookMarkImagePickerVC = nil 
    }
    
  }
  
  func setImageAtIndex(view: BookmarkImagePickerVC, scrollView: UIScrollView, images: [BookMarkArtIV]) {
    sendMyApiRequest(bookNameTextField.text!) { (url) in
      images[self.i].tag = self.i
      images[self.i].image = nil
      images[self.i].loadImageWithURL(url)
      self.i = self.i + 1
      
    }
  }
  
  func imageWasSelectedWithTag(view: BookMarkArtIVDelegate, image: BookMarkArtIV) {
    artworkImage.image = image.image
  }
  
}

extension NewBookMarkViewController: BookmarkImagePickerDataSource {
  
  func numberOfImagesToDisplay(scrollView: UIScrollView) -> Int {
    return 6
  }
  
}




