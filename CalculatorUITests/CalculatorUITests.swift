//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Avi Cohen on 21/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.staticTexts["8"].tap()
        collectionViewsQuery.staticTexts["+"].tap()
        collectionViewsQuery.childrenMatchingType(.Cell).elementBoundByIndex(8).otherElements.containingType(.StaticText, identifier:"8").element.tap()
        
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containingType(.StaticText, identifier:"-").element.tap()
        cellsQuery.otherElements.containingType(.StaticText, identifier:"6").element.tap()
        cellsQuery.otherElements.containingType(.StaticText, identifier:"=").element.tap()
        cellsQuery.otherElements.containingType(.StaticText, identifier:"10").element.tap()
        
    }
    
}
