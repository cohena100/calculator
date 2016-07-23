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

    override func updateViewConstraints() {
        super.updateViewConstraints()
        if heightConstraint == nil {
            return
        }
        let screenFrame = UIScreen.mainScreen().bounds
        let isLandscape = screenFrame.width > screenFrame.height
        let height = isLandscape ? 0.55 * screenFrame.height : 0.6 * screenFrame.height
        heightConstraint.constant = height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let keyboardCollectionViewController = keyboardCollectionViewController else {
            return
        }
        let screenFrame = UIScreen.mainScreen().bounds
        keyboardCollectionViewController.didRotate(screenFrame.width > screenFrame.height)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if heightConstraint == nil {
            let screenFrame = UIScreen.mainScreen().bounds
            let isLandscape = screenFrame.width > screenFrame.height
            let height = isLandscape ? 0.55 * screenFrame.height : 0.6 * screenFrame.height
            heightConstraint = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: height)
            heightConstraint.priority = UILayoutPriorityRequired - 1
            heightConstraint.active = true
            view.addConstraint(heightConstraint)
        }
    }
    
    override func loadView() {
        super.loadView()
        Model.sharedInstance.factory = ModelFactory()
        let nib = UINib(nibName: "KeyboardCollectionView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        let keyboardCollectionView = objects[0] as! KeyboardCollectionView
        view = keyboardCollectionView
        keyboardCollectionViewController = KeyboardCollectionViewController(keyboardCollectionView: keyboardCollectionView, view: view)
    }
    
}
