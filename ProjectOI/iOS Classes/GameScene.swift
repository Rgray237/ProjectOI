//
//  GameScene.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/7/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {

    var gameWorld:GameWorld = GameWorld()
    
    
    override func update(_ currentTime: TimeInterval) {
        gameWorld.updateWithDelta(delta: currentTime)
        
        for obj in gameWorld.gameObjects {
            
            guard (obj.renderNode != nil)  else {
                return
            }
            obj.renderNode.position = CGPoint(x: obj.pos.x,y: obj.pos.y)
            
        }
    }
    
}
