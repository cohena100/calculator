//
//  ViewController.swift
//  Calculator
//
//  Created by Avi Cohen on 21/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var keyboardCollectionView: KeyboardCollectionView!
    var isLandscape = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        let nib = UINib(nibName: "KeyboardCollectionView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        keyboardCollectionView = objects[0] as! KeyboardCollectionView
        keyboardCollectionView.delegate = self
        keyboardCollectionView.dataSource = self
        keyboardCollectionView.registerNib(UINib(nibName: "KeyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "key")
        keyboardCollectionView.registerNib(UINib(nibName: "DisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "display")
        view = keyboardCollectionView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let keyboardCollectionView = keyboardCollectionView else {
            return
        }
        let screenFrame = UIScreen.mainScreen().bounds
        isLandscape = screenFrame.width > screenFrame.height
        keyboardCollectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let displayHeight = (1.0 / 6.0) * view.frame.height
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: displayHeight)
        default:
            var keyWidth: CGFloat
            var keyHeight: CGFloat
            if isLandscape {
                keyWidth = (view.frame.width - 9) / 10
                keyHeight = (view.frame.height - displayHeight - 1 - 4) / 5
            } else {
                keyWidth = (view.frame.width - 3) / 4
                keyHeight = (view.frame.height - displayHeight - 1 - 4) / 5
            }
            return CGSize(width: keyWidth, height: keyHeight)
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return isLandscape ? 50 : 20
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("display", forIndexPath: indexPath) as! DisplayCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("key", forIndexPath: indexPath) as! KeyCollectionViewCell
            return cell
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
}