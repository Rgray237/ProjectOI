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
        let nd = [Node(imageNamed: "Guy1.png"),Node(imageNamed:"Guy2.png")]
        let go = GOAnimation(arrNodes:nd,intervalMS:100);
     
        XCTAssertEqual(go.animNodes[0].description, Node(imageNamed: "Guy1.png").description)
        XCTAssertEqual(go.animNodes[1].description, Node(imageNamed: "Guy2.png").description)

    }
    
    func testGOAnimationInterval()
    {
        let nd1 = Node(imageNamed: "Guy1.png")
        let nd2 = Node(imageNamed: "Guy2.png")
           let plyr = Player(settings: GameSettings(fileName: "TestGameSettings"))
           plyr.renderNode = Node(imageNamed: "Guy1.png")
           let nd = [nd1,nd2] as [Node]
           let go = GOAnimation(arrNodes:nd,intervalMS:1000);
        let pnt = CGPoint(x:0,y:0)
        XCTAssertEqual(go.currentNode().description, nd1.description)
        sleep(1)
        go.update(pnt: pnt)
        XCTAssertEqual(go.currentNode().description, nd2.description)
        sleep(1)
        go.update(pnt: pnt)
        XCTAssertEqual(go.currentNode().description, nd1.description)

    }
    
    func testInactiveNodesAreInvisible()
    {
        let nd1 = Node(imageNamed: "Guy1.png")
        let nd2 = Node(imageNamed: "Guy2.png")
       let plyr = Player(settings: GameSettings(fileName: "TestGameSettings"))
       plyr.renderNode = Node(imageNamed: "Guy1.png")
       let nd = [nd1,nd2] as [Node]
       let go = GOAnimation(arrNodes:nd,intervalMS:1000);
        let pnt = CGPoint(x:0,y:0)
        XCTAssertEqual(go.currentNode().alpha , 1)
        sleep(1)
        go.update(pnt: pnt)
        XCTAssertEqual(go.currentNode().alpha, 1)
        XCTAssertEqual(go.animNodes[0].alpha, 0)
        sleep(1)
        go.update(pnt: pnt)
        XCTAssertEqual(go.animNodes[1].alpha ,0 )
        XCTAssertEqual(go.animNodes[0].alpha, 1)
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
