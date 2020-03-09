//
//  DraggingPathTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 2/19/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class DraggingPathTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreate() {
        let dp = DraggingPath(startPnt: CGPoint(x:0,y:0))

        XCTAssertNotNil(dp)
    }
    
    func testAddSegments()
    {
         
        let dp = DraggingPath(startPnt: CGPoint(x:0,y:0))

        XCTAssertEqual(dp.numPnts, 1)
        dp.update(pnt: CGPoint(x:5,y:10))
    XCTAssertEqual(dp.numPnts, 1)
        sleep(1)
        dp.update(pnt: CGPoint(x:5,y:10))
        XCTAssertEqual(dp.numPnts, 2)
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
