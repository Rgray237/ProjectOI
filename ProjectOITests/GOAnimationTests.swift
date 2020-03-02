//
//  GOAnimationTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 3/2/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class GOAnimationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGOAnimation()
    {
        let plyr = Player(settings: GameSettings(fileName: "TestGameSettings"))
        plyr.renderNode = Node(imageNamed: "Guy1.png")
        let nd = [Node(imageNamed: "Guy1.png"),Node(imageNamed:"Guy2.png")] as! [Node]
        let go = GOAnimation(obj:plyr,arrNodes:nd)
     
        XCTAssertEqual(go.animNodes[0].description, Node(imageNamed: "Guy1.png").description)
        XCTAssertEqual(go.animNodes[1].description, Node(imageNamed: "Guy2.png").description)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
