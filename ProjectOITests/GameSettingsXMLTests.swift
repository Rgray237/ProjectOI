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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCanLoadPlayerSpeed()
    {
        let gs = GameSettings()
        XCTAssert(gs.getPlayerSpeed() > 0)
        XCTAssertNotNil(gs.getPlayerSpeed())
    }
    
    func testShouldShowFPS()
    {
        let gs = GameSettings()
        
        XCTAssertEqual(gs.getShowFPS(), true)
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
