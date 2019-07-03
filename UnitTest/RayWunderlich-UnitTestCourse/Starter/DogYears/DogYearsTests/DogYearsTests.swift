//
//  DogYearsTests.swift
//  DogYearsTests
//
//  Created by Peter Pohlmann on 01.07.19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
@testable import DogYears

class DogYearsTests: XCTestCase {
    
    let calc = Calculator()
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdd(){
        let result = calc.evaluate(op: "+", arg1: 2.0, arg2: 9.0)
        XCTAssert(result == 11.0, "Calculator add operation failed")
    }

    func testResult(){
        let res1 = calc.evaluate(op: "+", arg1: 2.0, arg2: 2.0)
        let res2 = calc.result
        XCTAssert(res1 == res2, "Calculator displayed result does not match")
    }
    
    func testClear(){
        let res1 = calc.evaluate(op: "+", arg1: 2.0, arg2: 2.0)
        XCTAssert(res1 != 0, "Result is already Zero")
        
        calc.clear()
        let result = calc.result
        
        XCTAssert(result == 0, "Clear does not work")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
