//
//  Position.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/19/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation

struct Vector3
{
    var x,y,z: Float
    
    func equals(vec:Vector3)->Bool
    {
        if (vec.x != x || vec.y != y || vec.z != z)
        {
            return false
        }
        return true
    }
}
