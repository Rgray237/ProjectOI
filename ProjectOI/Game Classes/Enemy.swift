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
    var timer = GameTimer(duration:1,descrip:"Countdown")
    func updateWithDelta(enemy: Enemy, plyr: Player, delta: CFTimeInterval) {
        enemy.w = 0
        timer.poll(currTime: CFAbsoluteTimeGetCurrent())
        if (timer.timesUp())
        {
            enemy.setState(state: nmeChasingState())
        }
    }
}

class nmeChasingState : EnemyState
{
    func updateWithDelta(enemy: Enemy,plyr:Player, delta: CFTimeInterval) {
        enemy.w = 5
    let direction = Math2d().getAngleBtwnPoints(enemy.pos,plyr.pos)

    enemy.setVelocity(velocity: Vector3(cos(direction) * enemy.speed, sin(direction)*enemy.speed, 0))
    }
}

class nmeAttackState : EnemyState
{
    func updateWithDelta(enemy:Enemy,plyr:Player, delta:CFTimeInterval)
    {
        
        
    }
}


class Enemy: SentientActor
{
    var type:String = ""
    var id:Int = 0
    var mEnemyType:EnemyType = .basic
    var state:EnemyState = nmeIdleState()
    var speed:Double = 30
    
    
    init(Type:Int,X:Double,Y:Double,ID:Int)
    {
        super.init()
        type = "basic"
        pos = Vector3(X,Y,0)
        id = ID
        size = CGSize(width:50,height:50)
        w = 0.5
        
    }
    
    func updateWithDelta(delta: CFTimeInterval, player:Player) {
        state.updateWithDelta(enemy: self,plyr: player, delta: delta)

        self.updateWithDelta(delta: delta)
    }
    
    func setState(state:EnemyState)
    {
        self.state = state
    }
    
    func printInfo()
    {
        print("Enemy Info:")
        print("ID: " + String(id) + " -- Type: " + String(describing: mEnemyType) + " -- X: " + String(pos.x) + " -- Y: " + String(pos.y))
    }
}

//let en = Enemy(type:EnemyType.bigdum, X:"3", Y:"4",ID:"35")
//en.printInfo()
