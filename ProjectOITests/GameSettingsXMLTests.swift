//
//  GameSettingsXMLTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/28/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class GameSettingsXMLTests: XCTestCase {

    var gs : GameSettings!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gs = GameSettings(fileName: "TestGameSettings")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCanLoadPlayerSpeed()
    {
        XCTAssert(gs.getPlayerSpeed() > 0)
        XCTAssertNotNil(gs.getPlayerSpeed())
    }
    
    func testCanLoadPlayerSize()
    {
        XCTAssertEqual(gs.getPlayerHeight(),10)
        XCTAssertEqual(gs.getPlayerSize(),CGSize(width: 10,height: 10))
    }
    
    func testShouldShowFPS()
    {
        let gs = GameSettings(fileName: "TestGameSettings")
        
        XCTAssertEqual(gs.getShowFPS(), true)

    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
