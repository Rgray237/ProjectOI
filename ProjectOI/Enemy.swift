//
//  Enemy.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/9/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

class Enemy: NSObject
{
    var type:String = ""
    var x:Int = 0
    var y:Int = 0
    var id:Int = 0
    
    init (Type:String, X:String, Y:String)
    {
        type = Type
        x = Int(X) ?? 0
        y = Int(Y) ?? 0
    }
    
    init (Type:String, X:String, Y:String, ID:String)
    {
        type = Type
        x = Int(X) ?? 0
        y = Int(Y) ?? 0
        id = Int(ID) ?? 0
    }
    
    
    func printInfo()
    {
        print("ID: " + String(id) + " -- Type: " + type + " -- X: " + String(x) + " -- Y: " + String(y))
    }
}
