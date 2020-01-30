
//
//  ProjectOITests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/8/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
import SpriteKit
@testable import ProjectOI


class GameWorldTests: XCTestCase {
   
    var gw:GameWorld = GameWorld()
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
  
  
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
    func testWorldXYBoundaries()
    {
        
    }
    
    
    func testAddActor()
    {
        XCTAssert(gw.getNumActors() == 0)
        let testActor = SentientActor()
        gw.addActor(actor: testActor)
        XCTAssert(gw.getNumActors()==1)
        let player = Player()
        gw.addActor(actor: player)
        XCTAssert(gw.getNumActors()==2)
    }
    
    func testGetPlayerProperly()
    {
        let player = Player()
        gw.addActor(actor: player)
        
        let gottenPlayer:SentientActor! = gw.getActorAtIndex(index:0)
        
        XCTAssert(gottenPlayer.pos.equals(vec:Vector3(0, 0, 0)))
        XCTAssert(gottenPlayer.getHealth()==100)
        let gottenPlayer2:SentientActor? = gw.getActorAtIndex(index: 1)//out of bounds
        XCTAssert(gottenPlayer2 == nil)
    }
    
    
    
    func testProperlyUpdated()
    {
        let player = Player()
        gw.addActor(actor: player)
        let gottenPlayer:SentientActor! = gw.getPlayer()
        XCTAssertEqual(gottenPlayer.pos, Vector3(0, 0, 0))
        gottenPlayer.setVelocity(velocity: Vector3(1, 2, 3))
        
        let timeSinceLastUpdate:CFTimeInterval = 3
        gw.updateWithDelta(delta: timeSinceLastUpdate)
        
        XCTAssertEqual(gottenPlayer.pos,Vector3(3, 6, 9))
        
    }
  
    
    func testMoveTo()
    {
        let player = Player()
        XCTAssertEqual(player.pos, Vector3(0, 0, 0))
        player.moveTo(pos: Vector3(10, 30, -1))
        XCTAssertEqual(player.pos, Vector3(10, 30, -1))
        
    }
    
    func testMoveWorld()
    {
        XCTAssertEqual(gw.pos, Vector3(0, 0, 0))
        gw.moveWorldTo(vec: Vector3(10, 0, 0))
        XCTAssertEqual(gw.pos, Vector3(10, 0, 0))
        gw.moveWorldBy(vec: Vector3(-7, 32, -5))
        XCTAssertEqual(gw.pos, Vector3(3, 32, -5))
    }
    
    
    
  func testProperNumberOfEnemies()
  {
    
  }
  
  func testObstaclesExist()
  {
    
  }
  
  func testNeuronsExist()
  {
    
  }
  
  func testPortalsExist()
  {
    
  }
  
  func testPlanesExist()
  {
    
  }
  
  
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
