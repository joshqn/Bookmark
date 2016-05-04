//
//  EditBookMarkViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/3/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit
import CoreData

protocol EditBookMarkDelegate: class {
  func editedBook(view: EditBookMarkViewController)
}

class EditBookMarkViewController: UIViewController {

  var context: NSManagedObjectContext?
  weak var delegate: EditBookMarkDelegate?
  
  var bookMark: BookMark?
  
  private let bookNameTextField = UITextField()
  private let pageTextField = UITextField()
  
  private let bookNameLabel = UILabel()
  private let pageLabel = UILabel()
  
  private let bookBottomBorder = UIView()
  private let pageBottomBorder = UIView()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.whiteColor()
    title = "Edit Book Mark"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))
    
    automaticallyAdjustsScrollViewInsets = false
    
    let tapGesture = UITapGestureRecognizer()
    tapGesture.addTarget(self, action: #selector(viewTapped))
    view.addGestureRecognizer(tapGesture)
    
    createUI()
    createAndAddConstraints()
    pageTextField.becomeFirstResponder()
    
    if let bookMark = bookMark {
      bookNameTextField.text = bookMark.name
      pageTextField.text = "\(bookMark.page!)"
    }
    
    
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
    updateDoneButton(forCharCount: 1)
    
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
  
  //MARK: Actions
  
  func viewTapped() {
    view.endEditing(true)
  }
  
  func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func done() {
    guard let context = context, let bookMark = bookMark else { return }
    bookMark.name = bookNameTextField.text!
    bookMark.page = Int(pageTextField.text ?? "0")
    
    do {
      try context.save()
    } catch {
      print("Error saving")
    }
    
    delegate?.editedBook(self)
    dismissViewControllerAnimated(true, completion: nil)
    
  }
}

extension EditBookMarkViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool  {
    let currentCharCount = textField.text?.characters.count ?? 0
    let newLength = currentCharCount + string.characters.count - range.length
    
    updateDoneButton(forCharCount: newLength)
    
    return true
  }
}










