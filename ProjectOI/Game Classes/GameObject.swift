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
    var pos:Vector3 = Vector3(x: 0, y: 0, z: 0)
    var vel:Vector3 = Vector3(x: 0, y: 0, z: 0)
    var dynamic:Bool = false
    var renderNode:Node!
    
    init()
    {
        
    }
    
    init(position:Vector3, dynamic:Bool)
    {
        self.pos = position
        self.vel = Vector3(x:0,y:0,z:0)
        self.dynamic = dynamic
    }
    
    
    init(position:Vector3,velocity:Vector3, dynamic:Bool)
    {
        self.pos = position
        self.vel = velocity
        self.dynamic = dynamic
    }
    
    func setVelocity(velocity: Vector3)
    {
        vel = velocity
    }
    
    func update()
    {
        pos.x += vel.x
        pos.y += vel.y
        pos.z += vel.z
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
