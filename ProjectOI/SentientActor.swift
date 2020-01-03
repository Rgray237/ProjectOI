//
//  SentientActor.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/26/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

class SentientActor : GameObject
{
    
    var health:Int!
    
    override init()
    {
        super.init()
        health = 100
    }
    
    func takeDamage(dmg:Int)
    {
        health -= dmg
    }
    
    func attackActorFor(dmg:Int,victim:SentientActor)
    {
        victim.takeDamage(dmg: dmg)
    }
    
    func isDead()->Bool
    {
        if (health <= 0)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func moveBy(vec:Vector3)
    {
        pos.x += vec.x
        pos.y += vec.y
        pos.z += vec.z
    }
    
    func moveBy(x:Float, y:Float, z:Float)
    {
        moveBy(vec: Vector3(x: x, y: y, z: z))
    }
    
    func getHealth() -> Int
    {
        return health
    }
}
