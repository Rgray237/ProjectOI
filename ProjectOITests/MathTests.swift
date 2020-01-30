//
//  MathTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/29/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class MathTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAngleBetweenPoints()
    {
        let mth = CommonMath()
        let pnt1 = Vector3(0, 0, 0)
        let pnt2 = Vector3(4, 4, 0)
        let pnt3 = Vector3(-4,4,0)
        let pnt4 = Vector3(-4,-4,0)
        let pnt5 = Vector3(4,-4,0)
        
        let pnt6 = Vector3(0,1,0)
        let pnt7 = Vector3(0,-1,0)
        let pnt8 = Vector3(1,0,0)
        let pnt9 = Vector3(-1,0,0)
        
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1,pnt2), Double.pi/4)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt3),Double.pi*3/4.0)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt4), Double.pi*5/4.0)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt5), Double.pi*7/4.0)

        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt1), 0)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt6), Double.pi/2)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt7), Double.pi * 3/2.0)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt8), 0)
        XCTAssertEqual(mth.getAngleBtwnPoints(pnt1, pnt9), Double.pi)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
