//
//  KeyboardCollectionViewMediator.swift
//  Calculator
//
//  Created by Avi Cohen on 24/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class KeyboardCollectionViewMediator {
    
    enum CellType {
        case display(id: String, text: String)
        case key(id: String, element: KeyboardKeyElement)
    }
    
    var acOrCIndex: (portrait: Int, landscape: Int)!
    var dataSourcePortrait: KeyboardKeyElements
    var dataSourceLandscape: KeyboardKeyElements
    let calculatorCommands: CalculatorCommands
    var isLandscape = false
    
    init() {
        let screenFrame = UIScreen.mainScreen().bounds
        isLandscape = screenFrame.width > screenFrame.height
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
        for i in 0 ..< dataSourcePortrait.elements.count {
            if dataSourcePortrait.elements[i].action == CalculatorCommands.Action.c || dataSourcePortrait.elements[i].action == CalculatorCommands.Action.ac {
                acOrCIndex = (landscape: 0, portrait: i)
                break
            }
        }
        for i in 0 ..< dataSourceLandscape.elements.count {
            if dataSourceLandscape.elements[i].action == CalculatorCommands.Action.c || dataSourceLandscape.elements[i].action == CalculatorCommands.Action.ac {
                acOrCIndex = (landscape: i, portrait: acOrCIndex.portrait)
                break
            }
        }
    }
    
    func sizeForItemAtIndexPath(indexPath: NSIndexPath, viewFrame frame: CGRect) -> CGSize {
        let displayHeight = (1.0 / 6.0) * frame.height
        switch indexPath.section {
        case 0:
            return CGSize(width: frame.width, height: displayHeight)
        default:
            var keyWidth: CGFloat
            var keyHeight: CGFloat
            let element: KeyboardKeyElement
            if isLandscape {
                element = dataSourceLandscape.elements[indexPath.row]
                keyWidth = (frame.width - 9) / 10
                keyHeight = (frame.height - displayHeight - 1 - 4) / 5
            } else {
                element = dataSourcePortrait.elements[indexPath.row]
                keyWidth = (frame.width - 3) / 4
                keyHeight = (frame.height - displayHeight - 1 - 4) / 5
            }
            if element.action == CalculatorCommands.Action.zero {
                keyWidth = keyWidth * 2 + 1
            }
            return CGSize(width: keyWidth, height: keyHeight)
        }
    }
    
    func didSelectItemAtIndexPath(indexPath: NSIndexPath) -> [NSIndexPath]? {
        switch indexPath.section {
        case 0:
            return nil
        default:
            let element = isLandscape ? dataSourceLandscape.elements[indexPath.row] : dataSourcePortrait.elements[indexPath.row]
            guard let action = element.action else {
                return nil
            }
            calculatorCommands.keyAction(action)
            dataSourcePortrait.elements[acOrCIndex.portrait] = KeyboardKeyElement(action: calculatorCommands.acOrC, color: dataSourcePortrait.elements[acOrCIndex.portrait].color)
            dataSourceLandscape.elements[acOrCIndex.landscape] = KeyboardKeyElement(action: calculatorCommands.acOrC, color: dataSourceLandscape.elements[acOrCIndex.landscape].color)
            let itemsToReload = isLandscape ? [NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: acOrCIndex.landscape, inSection: 1)] : [NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: acOrCIndex.portrait, inSection: 1)]
            return itemsToReload
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return isLandscape ? dataSourceLandscape.elements.count : dataSourcePortrait.elements.count
        }
    }
    
    func cellForItemAtIndexPath(indexPath: NSIndexPath) -> CellType {
        switch indexPath.section {
        case 0:
            return CellType.display(id: "display", text: calculatorCommands.display)
        default:
            let element = isLandscape ? dataSourceLandscape.elements[indexPath.row] : dataSourcePortrait.elements[indexPath.row]
            return CellType.key(id: "key", element: element)
        }
        
    }
    
    func numberOfSections() -> Int {
        return 2
    }
}
