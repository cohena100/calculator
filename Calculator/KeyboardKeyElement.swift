//
//  KeyboardKeyElement.swift
//  Calculator
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

struct KeyboardKeyElement {
    
    let action: CalculatorCommands.Action?
    let color: UIColor
    
    init(action: CalculatorCommands.Action, color: UIColor) {
        self.action = action
        self.color = color
    }
    
    init(d: [String: String]) {
        action = CalculatorCommands.Action(rawValue: d["action"]!)
        let color = d["color"]!
        switch color {
        case "silver":
            self.color = UIColor(white: 0.8, alpha: 1.0)
        case "gray":
            self.color = UIColor.grayColor()
        default:
            self.color = UIColor.orangeColor()
        }
    }
    
}