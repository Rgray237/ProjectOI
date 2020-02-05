//
//  Enemy.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/9/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

enum EnemyType
{
 case basic
 case ant
 case queen
 case speedy
 case bigdum
}

protocol  EnemyState
{

    func updateWithDelta(enemy:Enemy,plyr:Player, delta:CFTimeInterval)
}

class nmeIdleState : EnemyState
{
    
    
    func updateWithDelta(enemy: Enemy,plyr:Player, delta: CFTimeInterval) {
        
    let direction = Math2d().getAngleBtwnPoints(enemy.pos,plyr.pos)
        
    enemy.setVelocity(velocity: Vector3(cos(direction) * enemy.speed, sin(direction)*enemy.speed, 0))
        if Math2d().getSqDist(enemy.pos, plyr.pos) < 10
        {
            enemy.attackActorFor(dmg: 100, victim: plyr)
        }
    }
}

class nmeAttackState : EnemyState
{
    func updateWithDelta(enemy:Enemy,plyr:Player, delta:CFTimeInterval)
    {
        let direction = Math2d().getAngleBtwnPoints(enemy.pos,plyr.pos)
            
        enemy.setVelocity(velocity: Vector3(cos(direction) * 4*enemy.speed, sin(direction)*4*enemy.speed, 0))
        
    }
}


class Enemy: SentientActor
{
    var type:String = ""
    var id:Int = 0
    var mEnemyType:EnemyType = .basic
    var state:EnemyState = nmeIdleState()
    var speed:Double = 20
    
    init (Type:String, X:String, Y:String, ID:String)
    {
        super.init()
        type = Type
        pos = Vector3(Double(X) ?? 0, Double(Y) ?? 0, 0)
        id = Int(ID) ?? 0
    }
    /*
    init (type:EnemyType, X:String, Y:String, ID:String)
    {
        super.init()
        mEnemyType = type
        x = Int(X) ?? 0
        y = Int(Y) ?? 0
        id = Int(ID) ?? 0
    }
    */
    
    func updateWithDelta(delta: CFTimeInterval, player:Player) {
        state.updateWithDelta(enemy: self,plyr: player, delta: delta)
    }
    
    func printInfo()
    {
        print("ID: " + String(id) + " -- Type: " + String(describing: mEnemyType) + " -- X: " + String(pos.x) + " -- Y: " + String(pos.y))
    }
}

//let en = Enemy(type:EnemyType.bigdum, X:"3", Y:"4",ID:"35")
//en.printInfo()
