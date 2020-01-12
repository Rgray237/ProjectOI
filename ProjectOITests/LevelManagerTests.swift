//
//  LevelLoaderTests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/11/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
import SpriteKit
@testable import ProjectOI

class LevelManagerTests: XCTestCase {
    
    //var parentView = UIViewController()
    var gameScene:GameScene = GameScene()
    var skView:SKView = SKView()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       // parentView = MySceneViewController()
        //parentView.loadView()
        gameScene = GameScene()
        skView = SKView()
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

    }
    
    func testLoadsLevelToGameWorld()
    {
        
        let lvlManager = LevelManager(lvl: 0, scene: gameScene, view:skView)
        
        XCTAssertEqual(lvlManager.gameWorldLoaded(),false)
        lvlManager.dotherest()
        XCTAssertEqual(lvlManager.gameWorldLoaded(), true)
    }
    
    func testLoadsEnemiesToGameWorld()
    {
        let lvlManager = LevelManager(lvl: 0, scene: gameScene, view:skView)
        
        
        lvlManager.addEnemiesToGameWorld()
        XCTAssertEqual(lvlManager.gameWorld.actors.count, 3)
    }
    
    func testLoadsSpritesToEnemies()
    {
        let lvlManager = LevelManager(lvl: 0, scene: gameScene, view:skView)
        
        lvlManager.addRenderNodesToEnemies()
        XCTAssertEqual(gameScene.children.count, 0)
        lvlManager.addEnemiesToGameWorld()
        lvlManager.addRenderNodesToEnemies()
        lvlManager.gameWorld.setScene(scene: gameScene)
        XCTAssertEqual(gameScene.children.count, 3)

    }
    
    func testCreatesProperSceneWorldManager()
    {
        let lvlManager = LevelManager(lvl: 0,scene: gameScene, view:skView)
        lvlManager.addRenderNodesToEnemies()
        lvlManager.addEnemiesToGameWorld()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}
