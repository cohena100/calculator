//
//  ViewController.swift
//  Calculator
//
//  Created by Avi Cohen on 21/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var keyboardCollectionViewController: KeyboardCollectionViewController!
    
    override func loadView() {
        let nib = UINib(nibName: "KeyboardCollectionView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        let keyboardCollectionView = objects[0] as! KeyboardCollectionView
        view = keyboardCollectionView
        keyboardCollectionViewController = KeyboardCollectionViewController(keyboardCollectionView: keyboardCollectionView, view: view)
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        keyboardCollectionViewController.willRotate()
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let keyboardCollectionViewController = keyboardCollectionViewController else {
            return
        }
        let screenFrame = UIScreen.mainScreen().bounds
        keyboardCollectionViewController.didRotate(screenFrame.width > screenFrame.height)
    }

}
