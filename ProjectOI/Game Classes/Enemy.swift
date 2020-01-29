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
        let diff = CGPoint(x: plyr.pos.x - enemy.pos.x , y: plyr.pos.y - enemy.pos.y)
        let direction =
        enemy.setVelocity(velocity: Vector3(x: Double(diff.x) * enemy.speed, y: Double(diff.y)*enemy.speed, z: 0))
    }
}


class Enemy: SentientActor
{
    var type:String = ""
    var id:Int = 0
    var mEnemyType:EnemyType = .basic
    var state:EnemyState = nmeIdleState()
    var speed:Double = 0.5
    
    init (Type:String, X:String, Y:String, ID:String)
    {
        super.init()
        type = Type
        pos = Vector3(x: Double(X) ?? 0, y: Double(Y) ?? 0, z: 0)
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
