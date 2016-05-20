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
  
  var cell: BookMarksTableViewCell? {
    didSet {
      guard let cell = cell else {return}
      page = cell.page
      selectedNumber = page
    }
  }
  
  private var page: Int = 0
  private var selectedNumber = 0
  
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
      saveButton.topAnchor.constraintEqualToAnchor(self.popUpView.topAnchor, constant: 15).active = true
      
      popUpView.addSubview(picker)
      picker.dataSource = self
      picker.delegate = self
      picker.selectRow(page, inComponent: 0, animated: false)
      picker.translatesAutoresizingMaskIntoConstraints = false
      picker.topAnchor.constraintEqualToAnchor(saveButton.bottomAnchor).active = true
      picker.leadingAnchor.constraintEqualToAnchor(popUpView.leadingAnchor,constant: 15).active = true
      picker.bottomAnchor.constraintEqualToAnchor(popUpView.bottomAnchor, constant: -15).active = true
      picker.trailingAnchor.constraintEqualToAnchor(popUpView.trailingAnchor, constant: -15).active = true
      
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













