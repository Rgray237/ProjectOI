//
//  Position.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

class Vector2 : Equatable
{
    var x,y: Double
    
    init(_ x:Double,_ y:Double)
    {
        self.x = x
        self.y = y
    }
    
    init(x:Double,y:Double)
    {
        self.x = x
        self.y = y
    }
    
    func equals(vec:Vector2)->Bool
    {
        if (vec.x != x || vec.y != y)
        {
            return false
        }
        return true
    }
    
    func vecPrint()
    {
        print("X:" + String(x) + ", Y:" + String(y))
    }
    
    func toCGPoint()->CGPoint
    {
        return CGPoint(x: x, y: y)
    }
    
    static func == (lhs: Vector2, rhs: Vector2) -> Bool {
        return
            lhs.x == rhs.x &&
            lhs.y == rhs.y
    }
    
    
    
    static func * (lhs: Vector2,rhs: Double)->Vector2
    {
        return Vector2(lhs.x*rhs, lhs.y*rhs)
    }
    
    static func * (lhs: Vector2,rhs: Vector2)->Vector2
    {
        return Vector2(lhs.x*rhs.x, lhs.y*rhs.y)
    }
    
    
    static func + (lhs: Vector2, rhs: Vector2) ->Vector2
    {
        return Vector2(lhs.x+rhs.x, lhs.y+rhs.y)
    }
    
    static func + (lhs: Vector2, rhs: Vector3) ->Vector2
    {
        return Vector2(lhs.x+rhs.x, lhs.y+rhs.y)
    }
    
    static func - (lhs: Vector2, rhs: Vector2) ->Vector2
    {
        return Vector2(lhs.x-rhs.x, lhs.y-rhs.y)
    }
    
    
}


