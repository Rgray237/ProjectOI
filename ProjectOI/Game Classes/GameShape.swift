//
//  GameShape.swift
//  ProjectOI
//
//  Created by Robert Gray on 3/9/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class GameShape
{
    var pos:Vector3 = Vector3(0, 0, 0)
    var vel:Vector3 = Vector3(0, 0, 0)
    var dynamic:Bool = false
    var renderNode:ShapeNode!
    var size:CGSize = CGSize(width: 1, height: 1)
    var rot:Double = 0
    
    var w:Double = 0
    
    
    init(position:Vector3)
    {
        let pth = CGMutablePath()
        pth.move(to: position.toCGPoint2D())
        renderNode = ShapeNode(path: pth)
        
    }
    
}
