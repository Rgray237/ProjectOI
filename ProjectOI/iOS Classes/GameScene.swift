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
    var previousTime:CFTimeInterval = 0
    
    override func update(_ currentTime: TimeInterval) {
        
        gameWorld.updateWithDelta(delta: currentTime)
        for obj in gameWorld.gameObjects {
            if obj.renderNode != nil
            {
            obj.renderNode!.position = CGPoint(x: obj.pos.x,y: obj.pos.y)
            }
        }
        previousTime = currentTime
    }
    

    func addNodeToObject(renderNode:Node,obj:GameObject)
    {
        obj.renderNode = renderNode
        obj.renderNode.position = CGPoint(x: obj.pos.x,y: obj.pos.y)
        
        self.addChild(renderNode)
    }
    
}
