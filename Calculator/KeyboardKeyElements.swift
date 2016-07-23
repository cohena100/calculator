//
//  KeyboardKeyElements.swift
//  Calculator
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

class KeyboardKeyElements {

    var elements = [KeyboardKeyElement]()
    
    init(arr: [AnyObject]) {
        for element in arr {
            let item = element as! [String: String]
            elements.append(KeyboardKeyElement(d: item))
        }
    }
    
}