//
//  KeyboardCollectionViewController.swift
//  Calculator
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class KeyboardCollectionViewController: NSObject {
    
    static let silverColor = UIColor(white: 0.8, alpha: 1.0)
    static let grayColor = UIColor.grayColor()
    static let orangeColor = UIColor.orangeColor()
    
    var dataSourcePortrait = [
        KeyboardKeyElement(action: CalculatorCommands.Action.c, color: grayColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.plusMinus, color: grayColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.percent, color: grayColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.divide, color: orangeColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.seven, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.eight, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.nine, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.multiply, color: orangeColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.four, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.five, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.six, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.minus, color: orangeColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.one, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.two, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.three, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.plus, color: orangeColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.zero, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.point, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.equals, color: orangeColor),
        ]
    
    var dataSourceLandscape = [
        KeyboardKeyElement(action: CalculatorCommands.Action.c, color: grayColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.plusMinus, color: grayColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.percent, color: grayColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.divide, color: orangeColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.seven, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.eight, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.nine, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.multiply, color: orangeColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.four, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.five, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.six, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.minus, color: orangeColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.one, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.two, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.three, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.plus, color: orangeColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        
        KeyboardKeyElement(action: CalculatorCommands.Action.zero, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.point, color: silverColor),
        KeyboardKeyElement(action: CalculatorCommands.Action.equals, color: orangeColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        KeyboardKeyElement(action: nil, color: grayColor),
        ]
    
    let calculatorCommands: CalculatorCommands
    let keyboardCollectionView: KeyboardCollectionView
    var isLandscape: Bool
    weak var view: UIView!
    var acOrCIndex: Int!
    
    init(keyboardCollectionView: KeyboardCollectionView, view: UIView) {
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
                element = dataSourceLandscape[indexPath.row]
                keyWidth = (view.frame.width - 9) / 10
                keyHeight = (view.frame.height - displayHeight - 1 - 4) / 5
            } else {
                element = dataSourcePortrait[indexPath.row]
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
            let element = isLandscape ? dataSourceLandscape[indexPath.row] : dataSourcePortrait[indexPath.row]
            guard let action = element.action else {
                return
            }
            calculatorCommands.keyAction(action)
            dataSourcePortrait[acOrCIndex] = KeyboardKeyElement(action: calculatorCommands.acOrC, color: dataSourcePortrait[acOrCIndex].color)
            dataSourceLandscape[acOrCIndex] = KeyboardKeyElement(action: calculatorCommands.acOrC, color: dataSourceLandscape[acOrCIndex].color)
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
            return isLandscape ? dataSourceLandscape.count : dataSourcePortrait.count
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
            let element = isLandscape ? dataSourceLandscape[indexPath.row] : dataSourcePortrait[indexPath.row]
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