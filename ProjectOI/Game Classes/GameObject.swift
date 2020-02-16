//
//  GameObject.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

class GameObject
{
    var pos:Vector3 = Vector3(0, 0, 0)
    var vel:Vector3 = Vector3(0, 0, 0)
    var dynamic:Bool = false
    var renderNode:Node!
    var size:CGSize = CGSize(width: 1, height: 1)
    var rot:Double = 0
    var aabb1:Vector2 = Vector2(x: 0,y: 0)
    var aabb2:Vector2 = Vector2(x: 1,y: -1)
    var w:Double = 0
    var v1:Vector2 = Vector2(x:-1,y:1)
    var v2:Vector2 = Vector2(x:1,y:1)
    var v3:Vector2 = Vector2(x:1,y:-1)
    var v4:Vector2 = Vector2(x:-1,y:-1)
    
    init()
    {
        
    }
    
    init(position:Vector3, dynamic:Bool, size:CGSize)
    {
        self.pos = position
        self.vel = Vector3(0,0,0)
        self.dynamic = dynamic
        self.size = size
        calculateVertices()
        calculateAABB()
    }

    init(position:Vector3, dynamic:Bool)
    {
        self.pos = position
        self.vel = Vector3(0,0,0)
        self.dynamic = dynamic
        calculateVertices()
        calculateAABB()
    }
    
    
    init(position:Vector3,velocity:Vector3, dynamic:Bool, size:CGSize)
    {
        self.pos = position
        self.vel = velocity
        self.dynamic = dynamic
        self.size = size
        calculateVertices()
        calculateAABB()
    }
    
    func setVelocity(velocity: Vector3)
    {
        vel = velocity
    }
    
    //e.g.
    //1 means make their sizes equal.
    //2 means make the render node display twice as large as actual object
    func setRenderNodeSizeToFactorOfRealSize(factor:Double)
    {
        let widthScale = Double(renderNode.size.width / size.width)
        
        let renderScaleFactor = factor / widthScale
        renderNode.setScale(CGFloat(renderScaleFactor))
    }
    
    
    func setPos(pos:Vector3)
    {
        self.pos = pos
        calculateVertices()
        calculateAABB()
    }
    
    func setAngleDeg(_ angle:Double)
    {
        rot = angle * Double.pi/180.0
        calculateVertices()
        calculateAABB()
    }
    
    func setAngle(_ angle:Double)
    {
        rot = angle
        calculateVertices()
        calculateAABB()
    }
    
    func updateWithDelta(delta:CFTimeInterval)
    {
        if(self.dynamic)
        {
        pos.x += vel.x*delta
        pos.y += vel.y*delta
        pos.z += vel.z*delta
        rot += w*delta
        calculateVertices()
        calculateAABB()
        }
    }
    
    func bounce()
    {
        self.vel = self.vel * -1.0
    }
    
    
    func calculateVertices()
    {
        v1 = Vector2(x: Double(-size.width/2),y: Double(size.height/2))
        v2 = Vector2(x: Double(size.width/2), y: Double(size.height/2))
        v3 = Vector2(x: Double(size.width/2), y: Double(-size.height/2))
        v4 = Vector2(x: Double(-size.width/2), y: Double(-size.height/2))
    }
    
    func calculateAABB()
    {
        v1 = Math2d().getPntAfterRotation(inPoint: v1, angleRad: rot)
        v2 = Math2d().getPntAfterRotation(inPoint: v2, angleRad: rot)
        v3 = Math2d().getPntAfterRotation(inPoint: v3, angleRad: rot)
        v4 = Math2d().getPntAfterRotation(inPoint: v4, angleRad: rot)
        
        
        
        aabb1 = Vector2(x:[v1.x,v2.x,v3.x,v4.x].min()!,y:[v1.y,v2.y,v3.y,v4.y].max()!) + pos
        aabb2 = Vector2(x:[v1.x,v2.x,v3.x,v4.x].max()!,y: [v1.y,v2.y,v3.y,v4.y].min()!) + pos

    }
    
    func addNode(node:Node)
    {
        renderNode = node
        node.position = CGPoint(x: pos.x,y: pos.y)
        
    }
    
    func getPos()->Vector3
    {
        return pos
    }
    
    func getAngle()->Double
    {
        if (rot>=Double.pi*2)
        {
            return rot.truncatingRemainder(dividingBy: Double.pi*2)
        }
        return rot
    }
    
}
