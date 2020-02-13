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
        let gameObj = GameObject(position: Vector3(0,0,0),velocity: Vector3(4,2,5),dynamic: false, size:CGSize(width:1,height:1))
        //gameObj.update()
        XCTAssert(gameObj.pos.x == 0)
        gameObj.dynamic = true
        gameObj.updateWithDelta(delta:1)
        XCTAssert(gameObj.pos.x == 4)
        gameObj.updateWithDelta(delta:1)
        XCTAssert(gameObj.pos.z == 10)
    }
    
    func testRotationAndAngularVelocity()
    {
        let gameObj = GameObject(position: Vector3(0,0,0),velocity: Vector3(4,2,5),dynamic: false, size:CGSize(width:1,height:1))
        gameObj.setAngleDeg(90)
        XCTAssertEqual(gameObj.getAngle(),Double.pi/2)
        gameObj.w = Double.pi*2
        gameObj.updateWithDelta(delta:1)
        XCTAssertEqual(gameObj.getAngle(),Double.pi/2)
        gameObj.dynamic = true
        gameObj.updateWithDelta(delta:1)
        XCTAssertEqual(gameObj.getAngle(),Double.pi/2)
        gameObj.w = Double.pi*2+Double.pi/2
        gameObj.updateWithDelta(delta:1)
        XCTAssertEqual(gameObj.getAngle(),Double.pi)
        gameObj.setAngleDeg(360)
        XCTAssertEqual(gameObj.getAngle(),0)
    }
    
    func testRenderNodeScaling()
    {
        let gameObj = GameObject(position: Vector3(0,0,0),velocity: Vector3(4,2,5),dynamic: false, size:CGSize(width:10,height:10))
        
        let nd = Node(imageNamed: "Odie.png")
        gameObj.addNode(node:nd)
        //XCTAssertEqual(nd.size,CGSize(width:376.0,height:576.0))
        gameObj.setRenderNodeSizeToFactorOfRealSize(factor:1)
        XCTAssertEqual(nd.size.width,gameObj.size.width)
    
    }

    func testAABBCalc()
    {
        let gameObj = GameObject(position: Vector3(0,0,0),velocity: Vector3(4,2,5),dynamic: false, size:CGSize(width:5,height:10))
        XCTAssertEqual(gameObj.aabb1,Vector2(x: -2.5,y: 5))
        XCTAssertEqual(gameObj.aabb2,Vector2(x: 2.5,y: -5))
        
        gameObj.setAngle(Double.pi/2)
    XCTAssert(Math2d().pointsAreNegligiblyClose(gameObj.aabb1,Vector2(x:-5,y:2.5)))
        
    XCTAssert(Math2d().pointsAreNegligiblyClose(gameObj.aabb2,Vector2(x:5,y:-2.5)))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
