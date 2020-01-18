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
    
}
