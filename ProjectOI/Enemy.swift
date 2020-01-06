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

class Enemy: SentientActor
{
    var type:String = ""
    var x:Int = 0
    var y:Int = 0
    var id:Int = 0
    var mEnemyType:EnemyType = .basic
    
    init (Type:String, X:String, Y:String)
    {
        super.init()
        type = Type
        x = Int(X) ?? 0
        y = Int(Y) ?? 0
    }
    
    init (Type:String, X:String, Y:String, ID:String)
    {
        super.init()
        type = Type
        x = Int(X) ?? 0
        y = Int(Y) ?? 0
        id = Int(ID) ?? 0
    }
    
    init (type:EnemyType, X:String, Y:String, ID:String)
    {
        super.init()
        mEnemyType = type
        x = Int(X) ?? 0
        y = Int(Y) ?? 0
        id = Int(ID) ?? 0
    }
    
    
    func printInfo()
    {
         print("ID: " + String(id) + " -- Type: " + String(describing: mEnemyType) + " -- X: " + String(x) + " -- Y: " + String(y))
    }
}

//let en = Enemy(type:EnemyType.bigdum, X:"3", Y:"4",ID:"35")
//en.printInfo()
