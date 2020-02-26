//
//  Input.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/13/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation


class Input 
{
    var lastTouchedPos:CGPoint = CGPoint(x: 0, y: 0)
    
    init() {
        
    }
    
    func handleTouch(pos:CGPoint)
    {
        lastTouchedPos = pos
    }
}

class Tap : Input
{
    var tapPos:CGPoint = CGPoint(x: 0,y: 0)
    init(pos:CGPoint)
    {
        tapPos = pos
    }
}

class NA : Input
{
    
}
class Untap : Input
{
    
}

class Pan : Input
{
    var locationStartedPan : CGPoint
    var curLocation : CGPoint
    
    init(panStartPoint:CGPoint, newPoint:CGPoint)
    {
        locationStartedPan = panStartPoint
        curLocation = newPoint
        //print("pan finger from: ",locationStartedPan,",to : ",curLocation)
        
    
    }
}
