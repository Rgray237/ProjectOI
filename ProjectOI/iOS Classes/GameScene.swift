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
    var gameTimer:GameTimer!
    
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
        cameraNode.position = CGPoint(x: -0.5,
                                      y: -0.5)
            
      // self.addChild(cameraNode)
       //self.camera = cameraNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        
                
        gameWorld.player.handleInput(inp: Tap(pos: location))
        

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let untap = Untap()
        gameWorld.player.handleInput(inp: untap)
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
        
        let diff = currentTime - previousTime
        
        gameWorld.vel = gameWorld.player.vel * -1.0
        //gameWorld.moveWorldTo(vec: gameWorld.getPlayer().pos)
        //self.camera?.position = gameWorld.getPlayer().pos.toCGPoint2D()

        gameWorld.updateWithDelta(delta: diff)
        //worldPosToScenePos(pos: gameWorld.getPlayer().pos).toCGPoint2D()
        for obj in gameWorld.gameObjects {
            
            if obj.renderNode != nil
            {
                let vec = worldPosToScenePos(pos: obj.pos) 
                obj.renderNode!.position = CGPoint(x:vec.x,y:vec.y)
                obj.renderNode!.zRotation = CGFloat(obj.rot)
            }
        }
        previousTime = currentTime
    }
    

    func addNodeToObject(renderNode:Node,obj:GameObject)
    {
        obj.renderNode = renderNode
        let vec = worldPosToScenePos(pos: obj.pos)
        obj.renderNode.position = CGPoint(x: vec.x,y: vec.y)
        obj.setRenderNodeSizeToFactorOfRealSize(factor: 1)
        self.addChild(renderNode)
    }
    
}
