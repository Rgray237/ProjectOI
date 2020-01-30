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
    var dead:Bool = false
    
    override init()
    {
        super.init()
        health = 100
        dynamic = true
    }
    
    func takeDamage(dmg:Int)
    {
        health -= dmg
        if (health <= 0)
        {
            die()
        }
    }
    
    func attackActorFor(dmg:Int,victim:SentientActor)
    {
        victim.takeDamage(dmg: dmg)
    }
    
    func die()
    {
        dead = true
    }
    
    func isDead()->Bool
    {
        return dead
    }
    
    
    func moveBy(vec:Vector3)
    {
        pos.x += vec.x
        pos.y += vec.y
        pos.z += vec.z
    }
    
    func moveBy(x:Double, y:Double, z:Double)
    {
        moveBy(vec: Vector3(x, y, z))
    }
    
    func getHealth() -> Int
    {
        return health
    }
}
