//
//  First_CharadeTests.swift
//  First CharadeTests
//
//  Created by Olav Henriksen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit
import XCTest

class First_CharadeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: Timer
    
    // MARK: Actions
    
    func testStartSpill() {
        //
    }
    
    func testVelgOrd() {
        // Velg ord runden skal begynne med
    }
    
    func testStartRunde() {
        // Bytt bakgrunnsfarge til blå
        // Vis gjenstgående tid med hvit tekst
        // Start timer
    }
    
    func testNesteOrd(sender:UIButton) {
        // Vis rundeord
    }
    
    func testStoppRunde() {
        // Stopp timer
        // Bytt bakgrunnsfarge til grønn
        // Vis rundeord
    }
    
    func testGameOver() {
        // Stopp timer
        // Bytt bakgrunnsfarge til rød
        // vis rundeord
        // spill sørgemars
    }
    
    
}
