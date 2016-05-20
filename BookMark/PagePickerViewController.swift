//
//  PagePickerViewController.swift
//  BookMark
//
//  Created by Joshua Kuehn on 5/19/16.
//  Copyright © 2016 Joshua Kuehn. All rights reserved.
//

import UIKit

class PagePickerViewController: UIViewController {
  
  let popUpView = UIView()
  let saveButton = UIButton(type: .Custom)
  let picker = UIPickerView()
  let bookName = UITextField()
  let numberOfPagesLabel = UILabel()
  let numberOfPagesReadTextField = UITextField()
  
  var cell: BookMarksTableViewCell? {
    didSet {
      guard let cell = cell else {return}
      page = cell.page
      lastMarkedpage = page
      selectedNumber = page
      bookName.text = cell.nameLabel.text
    }
  }
  
  private var lastMarkedpage = 0
  private var page: Int = 0
  
  private var selectedNumber = 0 {
    didSet {
      pagesRead = selectedNumber - lastMarkedpage
      updateUI()
    }
  }
  private var pagesRead = 0
  
  weak var delegate: PagePickerVCDelegate?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    modalPresentationStyle = .Custom
    transitioningDelegate = self 
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    modalPresentationStyle = .Custom
    transitioningDelegate = self
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(exit))
      gestureRecognizer.cancelsTouchesInView = false
      gestureRecognizer.delegate = self
      view.addGestureRecognizer(gestureRecognizer)
      
      self.view.backgroundColor = UIColor.clearColor()
      
      view.addSubview(popUpView)
      popUpView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
      popUpView.layer.cornerRadius = 8
      popUpView.translatesAutoresizingMaskIntoConstraints = false
      popUpView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
      popUpView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
      popUpView.widthAnchor.constraintEqualToConstant(260).active = true
      popUpView.heightAnchor.constraintEqualToConstant(280).active = true
      
      saveButton.setImage(StyleKit.imageOfBookmarkid, forState: .Normal)
      saveButton.addTarget(self, action: #selector(close), forControlEvents: .TouchUpInside)
      
      popUpView.addSubview(saveButton)
      saveButton.translatesAutoresizingMaskIntoConstraints = false
      saveButton.trailingAnchor.constraintEqualToAnchor(self.popUpView.trailingAnchor, constant: -15).active = true
      saveButton.topAnchor.constraintEqualToAnchor(self.popUpView.topAnchor, constant: 10).active = true
      saveButton.setContentHuggingPriority(999, forAxis: .Horizontal)
      saveButton.setContentCompressionResistancePriority(999, forAxis: .Horizontal)
      
      popUpView.addSubview(picker)
      picker.dataSource = self
      picker.delegate = self
      picker.selectRow(page, inComponent: 0, animated: false)
      picker.translatesAutoresizingMaskIntoConstraints = false
      picker.topAnchor.constraintEqualToAnchor(saveButton.bottomAnchor).active = true
      picker.leadingAnchor.constraintEqualToAnchor(popUpView.leadingAnchor,constant: 15).active = true
      picker.bottomAnchor.constraintEqualToAnchor(popUpView.bottomAnchor, constant: 0).active = true
      picker.trailingAnchor.constraintEqualToAnchor(popUpView.trailingAnchor, constant: -15).active = true
      
      popUpView.addSubview(bookName)
      bookName.font = UIFont.systemFontOfSize(20, weight: UIFontWeightMedium)
      bookName.translatesAutoresizingMaskIntoConstraints = false
      bookName.leadingAnchor.constraintEqualToAnchor(self.popUpView.leadingAnchor,constant: 15).active = true
      bookName.topAnchor.constraintEqualToAnchor(self.popUpView.topAnchor, constant: 20).active = true
      bookName.trailingAnchor.constraintEqualToAnchor(saveButton.leadingAnchor, constant: -5).active = true
      
      popUpView.addSubview(numberOfPagesLabel)
      numberOfPagesLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightThin)
      numberOfPagesLabel.text = "Pages Read:"
      numberOfPagesLabel.translatesAutoresizingMaskIntoConstraints = false
      numberOfPagesLabel.leadingAnchor.constraintEqualToAnchor(self.popUpView.leadingAnchor,constant: 15).active = true
      numberOfPagesLabel.topAnchor.constraintEqualToAnchor(self.bookName.bottomAnchor, constant: 3).active = true
      
      popUpView.addSubview(numberOfPagesReadTextField)
      numberOfPagesReadTextField.font = UIFont.systemFontOfSize(18, weight: UIFontWeightThin)
      numberOfPagesReadTextField.translatesAutoresizingMaskIntoConstraints = false
      numberOfPagesReadTextField.text = "\(pagesRead)"
      numberOfPagesReadTextField.leadingAnchor.constraintEqualToAnchor(self.numberOfPagesLabel.trailingAnchor,constant: 5).active = true
      numberOfPagesReadTextField.topAnchor.constraintEqualToAnchor(self.bookName.bottomAnchor, constant: 3).active = true
      numberOfPagesReadTextField.trailingAnchor.constraintEqualToAnchor(saveButton.leadingAnchor, constant: -5).active = true
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func close() {
    delegate?.didPickNewPageWithNumber(self, page: selectedNumber)
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func exit() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func updateUI() {
    numberOfPagesReadTextField.text = "\(pagesRead)"
  }

}

//MARK: UIGestureRecognizerDelegate
extension PagePickerViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    return (touch.view == self.view)
  }
}

//MARK: UIViewControllerTransitioningDelegate
extension PagePickerViewController: UIViewControllerTransitioningDelegate {
  func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
    return DimmingPresentationController(presentedViewController: presented, presentingViewController: presenting)
  }
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return BounceAnimationController()
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideOutAnimationController()
  }
}

//MARK: UIPickerViewDataSource
extension PagePickerViewController: UIPickerViewDataSource {
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 500
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return "\(row)"
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
}

//MARK: UIPickerViewDelegate
extension PagePickerViewController: UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedNumber = row
  }
  
}

//MARK: PagePickerVCDelegate
protocol PagePickerVCDelegate: class {
  func didPickNewPageWithNumber(pagePickerVC: PagePickerViewController, page: Int)
}













