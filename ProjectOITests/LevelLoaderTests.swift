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

class LevelLoaderTests: XCTestCase {
    
    var parentView = UIViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parentView = MySceneViewController()
        parentView.loadView()
        
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testLoadsLevel()
    {
        let lvlLoad = LevelLoader(lvl: 1, parentViewController: parentView)

        lvlLoad.dotherest()
        XCTAssertNotEqual(lvlLoad.mainGameView,UIView())
    }
    
    func testProperNumberOfEnemiesInScene()
    {
        var lvlLoad = LevelLoader(lvl: 3, parentViewController: parentView)
        lvlLoad.dotherest()
        let numEnemies = lvlLoad.numberOfEnemiesInScene()
        XCTAssertEqual(3, numEnemies)
        
        lvlLoad = LevelLoader(lvl: 1, parentViewController: parentView)
        lvlLoad.dotherest()
        XCTAssertEqual(3, lvlLoad.numberOfEnemiesInScene())
        
    }
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
           let lvlLoad =  LevelLoader(lvl: 1, parentViewController: parentView)
            lvlLoad.dotherest()
        }
    }
    
}
