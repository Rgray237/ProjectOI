//
//  SentientActorTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/26/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class SentientActorTests: XCTestCase {

    var actor:SentientActor!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        actor = SentientActor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetActorHealth()
    {
        let health = actor.getHealth()
        XCTAssert(health == 100)
    }
    
    func testActorTakesDamage()
    {
        actor.takeDamage(dmg:43)
        XCTAssert(actor.getHealth() == 57)
        actor.takeDamage(dmg: 57)
        XCTAssert(actor.getHealth() == 0)
    }
    
    func testActorDiesUnderZero()
    {
        XCTAssert(actor.isDead() == false)
        actor.takeDamage(dmg: 99)
        XCTAssert(actor.isDead() == false)
        actor.takeDamage(dmg: 10000)
        XCTAssert(actor.isDead() == true)
    }
    
    func testActorDamagesOtherActor()
    {
        let actor2 = SentientActor()
        
        actor2.attackActorFor(dmg:30,victim:actor)
        
        XCTAssert(actor.getHealth()==70)
        actor2.attackActorFor(dmg: 70, victim: actor)
        XCTAssert(actor.getHealth()==0)
        XCTAssert(actor.isDead() == true)
    }
    
    func testMoveBy()
    {
        XCTAssert(actor.pos.equals(vec: Vector3(x: 0, y: 0, z: 0)))
        actor.moveBy(vec: Vector3(x: 3, y: -4, z: 0))
        XCTAssert(actor.pos.equals(vec: Vector3(x: 3, y: -4, z: 0)))
        actor.moveBy(vec: Vector3(x: 3, y: 6, z: 1))
        XCTAssert(actor.pos.equals(vec: Vector3(x: 6, y: 2, z: 1)))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
