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
    
    init()
    {
        
    }
    
    init(position:Vector3, dynamic:Bool, size:CGSize)
    {
        self.pos = position
        self.vel = Vector3(0,0,0)
        self.dynamic = dynamic
        self.size = size
    }

    init(position:Vector3, dynamic:Bool)
    {
        self.pos = position
        self.vel = Vector3(0,0,0)
        self.dynamic = dynamic
    }
    
    
    init(position:Vector3,velocity:Vector3, dynamic:Bool, size:CGSize)
    {
        self.pos = position
        self.vel = velocity
        self.dynamic = dynamic
        self.size = size
    }
    
    func setVelocity(velocity: Vector3)
    {
        vel = velocity
    }
    
    //1 means make their sizes equal.
    //2 means make the render node display twice as large as actual object
    func setRenderNodeSizeToFactorOfRealSize(factor:Double)
    {
        let widthScale = Double(renderNode.size.width / size.width)
        
        let renderScaleFactor = factor / widthScale
        renderNode.setScale(CGFloat(renderScaleFactor))
    }
    
    func update()
    {
        pos.x += vel.x
        pos.y += vel.y
        pos.z += vel.z
    }
    
    func moveTo(pos:Vector3)
    {
        self.pos = pos
    }
    
    
    func updateWithDelta(delta:CFTimeInterval)
    {
        pos.x += vel.x*delta
        pos.y += vel.y*delta
        pos.z += vel.z*delta
        
    }
    
    func addNode(node:Node)
    {
        renderNode = node
        node.position = CGPoint(x: pos.x,y: pos.y)
        
    }
    
}
