
//
//  ProjectOITests.swift
//  ProjectOITests
//
//  Created by Robert Gray on 12/8/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import XCTest
import SpriteKit
@testable import ProjectOI


class GameWorldTests: XCTestCase {
   
  var gw:GameWorld()
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       gw = GameWorld(Level:1)
    }
    
  
  
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
    
    func testWorldHasPlayer()
  {
    
  }
  
  func testProperNumberOfEnemies()
  {
    
  }
  
  func testObstaclesExist()
  {
    
  }
  
  func testNeuronsExist()
  {
    
  }
  
  func testPortalsExist()
  {
    
  }
  
  func testPlanesExist()
  {
    
  }
  
  
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
