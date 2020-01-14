//
//  PlayerTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class PlayerTests: XCTestCase {
    var player:Player!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        player = Player()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPlayerHealth()
    {
        
    }
    
    func testPlayerTakeDamage()
    {
        
    }
    
    func testStateChangesToDash()
    {
        XCTAssertEqual(player.getState(),"idle")
        let inp = Tap()
        player.handleInput(inp: inp)
        XCTAssertEqual(player.getState(), "dashing")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
