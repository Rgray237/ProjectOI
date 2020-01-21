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
    var inputWatcher:Input = Input()
    
    override var anchorPoint: CGPoint
    {
        get{
            return CGPoint(x: 0.5, y: 0.5)
        }
        set{
            //ignore
        }
    }
    
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    func setupCamera()
    {
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: self.size.width / 2,
                                      y: self.size.height / 2)
            
        self.addChild(cameraNode)
        self.camera = cameraNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        
        print(location)
        //gameWorld.moveWorldBy(vec: Vector3(x:Double(location.x)-Double(self.size.width/2), y:Double(location.y)-Double(self.size.height/2), z: 1))
        gameWorld.getPlayer().moveTo(pos:scenePosToWorldPos(pos: Vector3(x: Double(location.x), y: Double(location.y), z: 0)))
        gameWorld.getPlayer().pos.vecPrint()
        gameWorld.pos.vecPrint()

        
    }
    
    
    
    func rectOfGameWorldInScene()->CGRect
    {
        return CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    }
    
    func worldPosToScenePos(pos:Vector3)->Vector3
    {
        
        return pos+gameWorld.pos
    }
    
    func scenePosToWorldPos(pos:Vector3)->Vector3
    {
        
        return pos - gameWorld.pos
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        gameWorld.moveWorldTo(vec: gameWorld.getPlayer().pos)
        for obj in gameWorld.gameObjects {
            if obj.renderNode != nil
            {
                let vec = worldPosToScenePos(pos: obj.pos) 
                obj.renderNode!.position = CGPoint(x:vec.x,y:vec.y)

            }
        }
        previousTime = currentTime
    }
    

    func addNodeToObject(renderNode:Node,obj:GameObject)
    {
        obj.renderNode = renderNode
        let vec = worldPosToScenePos(pos: obj.pos)
        obj.renderNode.position = CGPoint(x: vec.x,y: vec.y)
        
        self.addChild(renderNode)
    }
    
}
