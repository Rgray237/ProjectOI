//
//  ConnectPointTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 2/18/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class ConnectPointTests: XCTestCase {

    var pnt : ConnectPoint!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        pnt = ConnectPoint(id:1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStartedDragging()
    {
        XCTAssertFalse(pnt.dragging)
        pnt.playerContacts()
        XCTAssertTrue(pnt.dragging)
        pnt.connectToPoint(pnt: ConnectPoint(id:2))
        XCTAssertTrue(pnt.isConnected())
        XCTAssertFalse(pnt.dragging)
        pnt.playerContacts()
        XCTAssertFalse(pnt.dragging)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
