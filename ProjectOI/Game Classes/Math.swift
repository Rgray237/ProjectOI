//
//  Math.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/29/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class CommonMath
{
    //Radians
    func getAngleBtwnPoints(_ pnt1:Vector3,_ pnt2:Vector3)->Double
    {
        if pnt1 == pnt2
        {
            return 0
        }
        let diff = pnt2 - pnt1
        if diff.x == 0
        {
            return diff.y >= 0 ? Double.pi/2.0 : Double.pi*3/2.0
        }
        if diff.y == 0
        {
            return diff.x >= 0 ? 0 : Double.pi
        }
        
        //tan = opposite over adjacent
        var angle = atan(diff.y/diff.x)
        
        if diff.x < 0
        {angle += Double.pi}
        
        else if diff.y < 0
        {angle += Double.pi*2}
        return angle
    }
}
