//
//  Position.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

struct Vector3 : Equatable
{
    var x,y,z: Double
    
    func equals(vec:Vector3)->Bool
    {
        if (vec.x != x || vec.y != y || vec.z != z)
        {
            return false
        }
        return true
    }
    
    static func == (lhs: Vector3, rhs: Vector3) -> Bool {
        return
            lhs.x == rhs.x &&
            lhs.y == rhs.y &&
            lhs.z == rhs.z
    }
    
    static func * (lhs: Vector3,rhs: Double)->Vector3
    {
        return Vector3(x: lhs.x*rhs, y: lhs.y*rhs, z: lhs.z*rhs)
    }
    
    static func * (lhs: Vector3,rhs: Vector3)->Vector3
    {
        return Vector3(x: lhs.x*rhs.x, y: lhs.y*rhs.y, z: lhs.z*rhs.z)
    }
    
    
    
}
