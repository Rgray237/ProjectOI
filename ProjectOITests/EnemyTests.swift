//
//  EnemyTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/26/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class EnemyTests: XCTestCase {

    var enmy:Enemy!
    var plyr:Player! //because what's an enemy without an enemy?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         enmy = Enemy(Type: 1, X: 3, Y: 4, ID: 2)
        plyr = Player()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnemyType()
    {
        XCTAssertEqual(enmy.mEnemyType, EnemyType.basic)
    }
    
    func testEnemyMovement()
    {
        enmy.setVelocity(velocity: Vector3(1,1,1))
        enmy.printInfo()
        enmy.updateWithDelta(delta: 1,player:plyr)
        XCTAssertEqual(enmy.pos,Vector3(4,5,1))
    }
    
    func testEnemyChase()
    {
        enmy.setState(state:nmeChasingState())
        let diff = enmy.pos - plyr.pos
        enmy.updateWithDelta(delta:0.1,player:plyr)
        XCTAssert((enmy.pos.x - plyr.pos.x) < diff.x)
        XCTAssert((enmy.pos.y - plyr.pos.y) < diff.y)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
