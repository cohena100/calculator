//
//  IModelFactory.swift
//  Calculator
//
//  Created by Avi Cohen on 23/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation
import CalculatorSDK

protocol IModelFactory {
    
    func getCalculatorCommands() -> CalculatorCommands
    
}