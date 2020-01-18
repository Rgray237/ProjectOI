//
//  InputTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/18/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class InputTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTouchAtPoint()
    {
        let inp = Input()
        let pnt = CGPoint(x: 4,y: 5)
        XCTAssertEqual(inp.lastTouchedPos, CGPoint(x: 0,y: 0))
        inp.handleTouch(pos:pnt)
        XCTAssertEqual(inp.lastTouchedPos, pnt)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
