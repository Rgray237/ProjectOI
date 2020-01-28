//
//  LevelTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/26/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class LevelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLevel()
    {
        let enms : [Enemy] = [Enemy(Type: "basic", X: "4", Y: "5", ID: "1") , Enemy(Type: "basic", X: "6", Y: "7", ID: "2")]
        
        let lvl = Level(enemies: enms)
        XCTAssertEqual(lvl.getNumEnemies(), 2)
        XCTAssertEqual(lvl.numPhases, 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
