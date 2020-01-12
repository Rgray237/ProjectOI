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
}
