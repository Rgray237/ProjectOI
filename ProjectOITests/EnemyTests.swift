//
//  EnemyTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/26/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class EnemyTests: XCTestCase {

    var enmy  = Enemy(Type: 1, X: 3, Y: 4, ID: 2)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnemyType()
    {
        XCTAssertEqual(enmy.mEnemyType, EnemyType.basic)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
