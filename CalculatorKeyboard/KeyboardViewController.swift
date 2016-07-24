//
//  KeyboardViewController.swift
//  CalculatorKeyboard
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var keyboardCollectionViewController: KeyboardCollectionViewController!
    var heightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        heightConstraint.constant = calculateViewHeight()
        keyboardCollectionViewController.willRotate()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Model.sharedInstance.factory = ModelFactory()
        let nib = UINib(nibName: "KeyboardCollectionView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        let keyboardCollectionView = objects[0] as! KeyboardCollectionView
        keyboardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        keyboardCollectionViewController = KeyboardCollectionViewController(keyboardCollectionView: keyboardCollectionView)
        view.addSubview(keyboardCollectionView)
        var c = NSLayoutConstraint(item: keyboardCollectionView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        view.addConstraint(c)
        c = NSLayoutConstraint(item: keyboardCollectionView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0)
        view.addConstraint(c)
        c = NSLayoutConstraint(item: keyboardCollectionView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0)
        view.addConstraint(c)
        c = NSLayoutConstraint(item: keyboardCollectionView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        view.addConstraint(c)
        let height = calculateViewHeight()
        heightConstraint = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        view.addConstraint(heightConstraint)
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let keyboardCollectionViewController = keyboardCollectionViewController else {
            return
        }
        let screenFrame = UIScreen.mainScreen().bounds
        keyboardCollectionViewController.didRotate(screenFrame.width > screenFrame.height)
    }
    
    private func calculateViewHeight() -> CGFloat {
        let screenFrame = UIScreen.mainScreen().bounds
        let isLandscape = screenFrame.width > screenFrame.height
        return isLandscape ? 0.55 * screenFrame.height : 0.6 * screenFrame.height
    }
    
}
