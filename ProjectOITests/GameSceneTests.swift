//
//  GameSceneTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/12/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
import SpriteKit
@testable import ProjectOI

class GameSceneTests: XCTestCase {

    var scene:GameScene!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        scene = GameScene(size: CGSize(width: 500,height: 500))
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasGameWorld()
    {
        scene.gameWorld.addActor(actor: Enemy(Type: "basic", X: "4", Y: "6", ID: "1"))
        XCTAssertEqual(scene.gameWorld.getNumActors(),1)
    }

    func testUpdatesGameWorld()
    {
        scene.gameWorld.addActor(actor: Enemy(Type: "basic", X: "4", Y: "6", ID: "1"))
        scene.gameWorld.getActorAtIndex(index: 0)?.setVelocity(velocity: Vector3(3, 3, 3))
        
        scene.update(3)
        XCTAssertEqual(scene.gameWorld.getActorAtIndex(index: 0)?.pos,Vector3(13, 15, 9))
        
    }
    
    func testNodesStayTiedToWorldObjects()
    {
        
        scene.gameWorld.addActor(actor: Enemy(Type: "basic", X: "4", Y: "6", ID: "1"))
        scene.gameWorld.getActorAtIndex(index: 0)?.setVelocity(velocity: Vector3(3, 3, 3))
        let myNode = Node(imageNamed:"Odie.png")
    scene.addNodeToObject(renderNode:myNode,obj:scene.gameWorld.getActorAtIndex(index: 0)!)

        scene.update(3)
        
        XCTAssertEqual(scene.gameWorld.getActorAtIndex(index: 0)?.pos,Vector3(13, 15, 9))
        XCTAssertEqual(scene.gameWorld.getActorAtIndex(index: 0)?.renderNode.position, CGPoint(x: 13, y: 15))
        
        XCTAssertEqual(scene.children.count, 1 )
    }
    
    
    func testRectOfGameWorldInScene()
    {
        XCTAssertEqual(scene.rectOfGameWorldInScene(), CGRect(x: 0, y: 0, width: 500, height: 500))
        
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
