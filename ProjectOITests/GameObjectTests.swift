//
//  GameObject.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI


class GameObjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testObjectDefaultPosition()
    {
        let gameObj = GameObject()
        XCTAssertEqual(gameObj.pos,Vector3(0, 0, 0))
        
    }
    
    func testObjDynamic()
    {
        let pos = Vector3(3,5,6)
        let gameObj = GameObject(position: pos,dynamic: true)
        XCTAssert(gameObj.dynamic == true)
    }
    
    func testDynamics()
    {
        let gameObj = GameObject(position: Vector3(0,0,0),velocity: Vector3(4,2,5),dynamic: false)
        //gameObj.update()
        XCTAssert(gameObj.pos.x == 0)
        gameObj.dynamic = true
        gameObj.update()
        XCTAssert(gameObj.pos.x == 4)
        gameObj.update()
        XCTAssert(gameObj.pos.z == 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
