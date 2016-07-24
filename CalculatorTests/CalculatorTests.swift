//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Avi Cohen on 21/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    static let minusTen = "-10"
    static let tenPercent = "0.1"
    static let zero = "0"
    static let one = "1"
    static let two = "2"
    static let five = "5"
    static let fivePoint = "5."
    static let seven = "7"
    static let ten = "10"
    static let tenPoint5 = "10.5"
    static let fifteen = "15"
    static let twenty = "20"
    static let plusOp = "+"
    static let minusOp = "-"
    static let multiplyOp = "*"
    static let divideOp = "/"
    
    var commands: CalculatorCommands!
    var proxy: ICalculatorProxy!
    
    override func setUp() {
        super.setUp()
        proxy = CalculatorProxy()
        commands = CalculatorCommands(calculatorProxy: proxy)
    }
    
    override func tearDown() {
        commands = nil
        proxy = nil
        super.tearDown()
    }
    
    func test_5Plus5equals_10() {
        commands.keyAction(.five)
        XCTAssert(commands.display == CalculatorTests.five)
        commands.keyAction(.plus)
        XCTAssert(commands.display == CalculatorTests.five)
        commands.keyAction(.two)
        XCTAssert(commands.display == CalculatorTests.two)
        commands.keyAction(.equals)
        XCTAssert(commands.display == CalculatorTests.seven)
    }
    
    func test_5Plus5Plus5Equals_15() {
        commands.keyAction(.five)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        commands.keyAction(.equals)
        XCTAssert(commands.display == CalculatorTests.fifteen)
    }
    
    func test_5Point5Plus5Equals10Point5() {
        commands.keyAction(.five)
        commands.keyAction(.point)
        commands.keyAction(.five)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        commands.keyAction(.equals)
        XCTAssert(commands.display == CalculatorTests.tenPoint5)
    }
    
    func test_Minus5Plus5Equals_0() {
        commands.keyAction(.five)
        commands.keyAction(.plusMinus)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        commands.keyAction(.equals)
        XCTAssert(commands.display == CalculatorTests.zero)
    }
    
    func test_5Point_5Point() {
        commands.keyAction(.five)
        commands.keyAction(.point)
        XCTAssert(commands.display == CalculatorTests.fivePoint)
    }
    
    func test_5Plus5Equals5Plus5Equals_10() {
        commands.keyAction(.five)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        commands.keyAction(.equals)
        commands.keyAction(.five)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        XCTAssert(commands.display == CalculatorTests.zero)
    }
    
    func test_5Plus5EqualsPlus5Equals_15() {
        commands.keyAction(.five)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        commands.keyAction(.equals)
        commands.keyAction(.plus)
        commands.keyAction(.five)
        XCTAssert(commands.display == CalculatorTests.fifteen)
    }
    
}
