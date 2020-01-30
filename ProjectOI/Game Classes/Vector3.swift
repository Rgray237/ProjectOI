//
//  Position.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

class Vector3 : Equatable
{
    var x,y,z: Double
    
    init(_ x:Double,_ y:Double, _ z:Double)
    {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func equals(vec:Vector3)->Bool
    {
        if (vec.x != x || vec.y != y || vec.z != z)
        {
            return false
        }
        return true
    }
    
    func vecPrint()
    {
        print("X:" + String(x) + ", Y:" + String(y) + ", Z:" + String(z))
    }
    
    func toCGPoint2D()->CGPoint
    {
        return CGPoint(x: x, y: y)
    }
    
    static func == (lhs: Vector3, rhs: Vector3) -> Bool {
        return
            lhs.x == rhs.x &&
            lhs.y == rhs.y &&
            lhs.z == rhs.z
    }
    
    
    
    static func * (lhs: Vector3,rhs: Double)->Vector3
    {
        return Vector3(lhs.x*rhs, lhs.y*rhs, lhs.z*rhs)
    }
    
    static func * (lhs: Vector3,rhs: Vector3)->Vector3
    {
        return Vector3(lhs.x*rhs.x, lhs.y*rhs.y, lhs.z*rhs.z)
    }
    
    
    static func + (lhs: Vector3, rhs: Vector3) ->Vector3
    {
        return Vector3(lhs.x+rhs.x, lhs.y+rhs.y, lhs.z+rhs.z)
    }
    
    static func - (lhs: Vector3, rhs: Vector3) ->Vector3
    {
        return Vector3(lhs.x-rhs.x, lhs.y-rhs.y, lhs.z-rhs.z)
    }
    
    
}


