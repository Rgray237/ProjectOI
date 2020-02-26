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
        pnt.renderNode = Node(imageNamed: "Odie.png")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStartedDragging()
    {
        XCTAssertFalse(pnt.dragging)
        pnt.playerContacts()
        XCTAssertTrue(pnt.dragging)
        let pnt2 = ConnectPoint(id:2)
        pnt2.renderNode = Node(imageNamed: "Odie.png")
        pnt.connectToPoint(pnt: pnt2)
        XCTAssertTrue(pnt.isConnected())
        XCTAssertFalse(pnt.dragging)
        pnt.playerContacts()
        XCTAssertFalse(pnt.dragging)
    }
    
    func testOpenClosed()
    {
        XCTAssert(pnt.isOpen())
        pnt.playerContacts()
        XCTAssert(pnt.isClosed())
        let pnt2 = ConnectPoint(id:2)
        pnt2.renderNode = Node(imageNamed: "Odie.png")
        XCTAssert(pnt2.isOpen())
        pnt.connectToPoint(pnt: pnt2)
        XCTAssert(pnt.isClosed())
        XCTAssert(pnt2.isClosed())
        
        
    }
    
    func testGetConnectionPoint()
    {
        XCTAssertNil(pnt.getConnectedPoint())
        
        let pnt2 = ConnectPoint(id:2)
        pnt2.renderNode = Node(imageNamed: "Odie.png")
        
        pnt.connectToPoint(pnt: pnt2)
        XCTAssertEqual(pnt.getConnectedPoint(), pnt2)
        XCTAssertEqual(pnt2.getConnectedPoint(), pnt)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
