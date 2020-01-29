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
        let pnt1 = Vector3(x: 0, y: 0,z: 0)
        let pnt2 = Vector3(x: 4, y: 3,z: 0)
        
        let angle = CommonMath().getAngleBtwnPoints(pnt1:pnt1,pnt2:pnt2)
        XCTAssertEqual(angle, 0.6435011087932844)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
