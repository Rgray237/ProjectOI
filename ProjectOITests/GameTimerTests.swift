//
//  GameTimeTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/26/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class TimerTests: XCTestCase {

    var time:GameTimer!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimeElapsed()
    {
        time = GameTimer(duration:5, descrip:"Testing time")
        XCTAssertEqual(time.timeRemaining, 5 )
        XCTAssertEqual(time.timesUp(), false)
        sleep(5)
        time.poll(currTime: CFAbsoluteTimeGetCurrent())
        XCTAssert(time.timeRemaining <= 0)
        XCTAssertEqual(time.timesUp(), true)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
