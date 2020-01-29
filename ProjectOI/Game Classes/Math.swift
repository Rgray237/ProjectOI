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
    func getAngleBtwnPoints(pnt1:Vector3,pnt2:Vector3)->Double
    {
        let diff = pnt2 - pnt1
        diff.vecPrint()
        //tan = opposite over adjacent
        let angle = atan(diff.y/diff.x)
        
        return angle
    }
}
