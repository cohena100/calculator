//
//  KeyboardCollectionViewController.swift
//  Calculator
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class KeyboardCollectionViewController: NSObject {
    
    let keyboardCollectionView: KeyboardCollectionView
    weak var view: UIView!
    let mediator = KeyboardCollectionViewMediator()
    
    init(keyboardCollectionView: KeyboardCollectionView, view: UIView) {
        self.keyboardCollectionView = keyboardCollectionView
        self.keyboardCollectionView.registerNib(UINib(nibName: "KeyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "key")
        self.keyboardCollectionView.registerNib(UINib(nibName: "DisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "display")
        self.view = view
        super.init()
        self.keyboardCollectionView.delegate = self
        self.keyboardCollectionView.dataSource = self
    }
    
    func willRotate() {
        self.keyboardCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func didRotate(isLandscape: Bool) {
        mediator.isLandscape = isLandscape
        self.keyboardCollectionView.reloadData()
    }
    
}

extension KeyboardCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return mediator.sizeForItemAtIndexPath(indexPath, viewFrame: view.frame)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let itemsToReload = mediator.didSelectItemAtIndexPath(indexPath) {
            keyboardCollectionView.reloadItemsAtIndexPaths(itemsToReload)
        }
    }
    
}

extension KeyboardCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediator.numberOfItemsInSection(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellType = mediator.cellForItemAtIndexPath(indexPath)
        switch cellType {
        case .display(let id, let text):
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as! DisplayCollectionViewCell
            cell.numberLabel.text = text
            return cell
        case .key(let id, let element):
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as! KeyCollectionViewCell
            cell.backgroundColor = element.color
            cell.symbolLabel.text = element.action?.rawValue
            return cell
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return mediator.numberOfSections()
    }
}