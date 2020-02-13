//
//  Math.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/29/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class Math2d
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
    
    func getSqDist(_ pnt1:Vector3,_ pnt2:Vector3)->Double
    {
        
        return pow(pnt2.x-pnt1.x,2) + pow(pnt2.y-pnt1.y,2)
    }
    
    func getPntAfterRotation(inPoint:Vector2,angleRad:Double)->Vector2
    {
        let x2 = inPoint.x * cos(angleRad) - inPoint.y * sin(angleRad)
        let y2 = inPoint.x * sin(angleRad) + inPoint.y * cos(angleRad)
        return Vector2(x: x2, y: y2)
    }
    
    func pointsAreNegligiblyClose(_ pnt1:Vector2,_ pnt2:Vector2)->Bool
    {
        let diff1 = pnt1.x-pnt2.x
        let diff2 = pnt1.y-pnt2.y
        print(diff1)
        print(diff2)
        if abs(diff1) < 0.0000001 && abs(diff2) < 0.0000001
        {
            return true
        }
        
        return false
    }
    
    
}
