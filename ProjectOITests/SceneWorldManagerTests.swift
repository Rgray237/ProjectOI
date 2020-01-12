//
//  SceneWorldManagerTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 1/12/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import XCTest
@testable import ProjectOI

class SceneWorldManagerTests: XCTestCase {

    var manager:SceneWorldManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let wrld = GameWorld()
        let scene = GameScene(size: CGSize(width: 500, height: 500))
        
        manager = SceneWorldManager(scene:scene,world:wrld)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasGameWorldAndScene()
    {
        XCTAssertNotNil(manager.getWorld())
        XCTAssertNotNil(manager.getScene())
    }
    
    func testNodesGoWhereGameWorldGoes()
    {
        manager.gameWorld.addActor(actor: Enemy(Type: "basic", X: "4", Y: "6", ID: "1"))
        manager.gameWorld.getActorAtIndex(index: 0)?.setVelocity(velocity: Vector3(x: 3, y: 3, z: 3))
        let nod = Node(imageNamed: "Odie.png")
        manager.gameWorld.addNodeToObjectAtIndex(index: 0, renderNode: nod)
        
        manager.gameScene.update(3)
        let actr = manager.gameWorld.getActorAtIndex(index: 0)!
        XCTAssertEqual(actr.pos,Vector3(x: 13, y: 15, z: 9))//Gameworld pos
        manager.gameScene.addChild(actr.renderNode)
        XCTAssertEqual(manager.gameScene.children[0].position, CGPoint(x: 13,y: 15))//GameScene pos for nodes
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
