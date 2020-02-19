//
//  VectorNodeTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 2/19/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class VectorNodeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateVectorNode() {
        
        let pth = CGMutablePath()
        pth.addLine(to: CGPoint(x: 4, y: 5))
        pth.addLine(to: CGPoint(x:6,y:8))
        
        let vn = VectorNode(path: pth)
        XCTAssertNotNil(vn)
        
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
