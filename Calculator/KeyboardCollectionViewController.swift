//
//  KeyboardCollectionViewController.swift
//  Calculator
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class KeyboardCollectionViewController: NSObject {
    
    let calculatorCommands: CalculatorCommands
    let keyboardCollectionView: KeyboardCollectionView
    var isLandscape: Bool
    weak var view: UIView!
    var acOrCIndex: Int!
    var dataSourcePortrait: KeyboardKeyElements
    var dataSourceLandscape: KeyboardKeyElements
    
    init(keyboardCollectionView: KeyboardCollectionView, view: UIView) {
        var path = NSBundle.mainBundle().pathForResource("PortraitElements", ofType: "plist")!
        var arr = NSArray(contentsOfFile: path) as! [AnyObject]
        dataSourcePortrait = KeyboardKeyElements(arr: arr)
        path = NSBundle.mainBundle().pathForResource("Themes", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path) as! [NSObject: AnyObject]
        let theme = dict["theme"] as! String
        path = NSBundle.mainBundle().pathForResource(theme, ofType: "plist")!
        arr = NSArray(contentsOfFile: path) as! [AnyObject]
        dataSourceLandscape = KeyboardKeyElements(arr: arr)
        calculatorCommands = Model.sharedInstance.factory.getCalculatorCommands()
        self.keyboardCollectionView = keyboardCollectionView
        self.keyboardCollectionView.registerNib(UINib(nibName: "KeyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "key")
        self.keyboardCollectionView.registerNib(UINib(nibName: "DisplayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "display")
        self.isLandscape = false
        self.view = view
        super.init()
        self.keyboardCollectionView.delegate = self
        self.keyboardCollectionView.dataSource = self
    }
    
    func didRotate(isLandscape: Bool) {
        self.isLandscape = isLandscape
        self.keyboardCollectionView.reloadData()
    }
    
}

extension KeyboardCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let displayHeight = (1.0 / 6.0) * view.frame.height
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: displayHeight)
        default:
            var keyWidth: CGFloat
            var keyHeight: CGFloat
            let element: KeyboardKeyElement
            if isLandscape {
                element = dataSourceLandscape.elements[indexPath.row]
                keyWidth = (view.frame.width - 9) / 10
                keyHeight = (view.frame.height - displayHeight - 1 - 4) / 5
            } else {
                element = dataSourcePortrait.elements[indexPath.row]
                keyWidth = (view.frame.width - 3) / 4
                keyHeight = (view.frame.height - displayHeight - 1 - 4) / 5
            }
            if element.action == CalculatorCommands.Action.zero {
                keyWidth = keyWidth * 2 + 1
            }
            return CGSize(width: keyWidth, height: keyHeight)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            return
        default:
            let element = isLandscape ? dataSourceLandscape.elements[indexPath.row] : dataSourcePortrait.elements[indexPath.row]
            guard let action = element.action else {
                return
            }
            calculatorCommands.keyAction(action)
            dataSourcePortrait.elements[acOrCIndex] = KeyboardKeyElement(action: calculatorCommands.acOrC, color: dataSourcePortrait.elements[acOrCIndex].color)
            dataSourceLandscape.elements[acOrCIndex] = KeyboardKeyElement(action: calculatorCommands.acOrC, color: dataSourceLandscape.elements[acOrCIndex].color)
            keyboardCollectionView.reloadItemsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: acOrCIndex, inSection: 1)])
        }
    }
    
}

extension KeyboardCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return isLandscape ? dataSourceLandscape.elements.count : dataSourcePortrait.elements.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("display", forIndexPath: indexPath) as! DisplayCollectionViewCell
            cell.numberLabel.text = calculatorCommands.display
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("key", forIndexPath: indexPath) as! KeyCollectionViewCell
            let element = isLandscape ? dataSourceLandscape.elements[indexPath.row] : dataSourcePortrait.elements[indexPath.row]
            cell.backgroundColor = element.color
            cell.symbolLabel.text = element.action?.rawValue
            if let acOrCAction = element.action where acOrCAction == CalculatorCommands.Action.c {
                acOrCIndex = indexPath.row
            }
            return cell
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
}