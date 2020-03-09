//
//  DraggingPath.swift
//  ProjectOI
//
//  Created by Robert Gray on 2/19/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation
import SpriteKit

class DraggingPath : GameObject
{
    var pnts : [CGPoint]
    var numPnts : Int
    var timer : GameTimer
    var interval : CFTimeInterval = 0.1
    var shapeNode : SKShapeNode
    var path : CGMutablePath
    
    init(startPnt: CGPoint)
    {
        numPnts = 1
        pnts = []
        timer = GameTimer(duration: interval, descrip: "Time between segments added")
        path = CGMutablePath()
        let shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 256, height: 256), cornerRadius: 64).cgPath
        shape.position = startPnt
        shape.fillColor = UIColor.red
        shape.strokeColor = UIColor.blue
        shape.lineWidth = 10
        shapeNode = shape
        super.init()
        pos = Vector3(Double(startPnt.x),Double(startPnt.y),0)
        pnts.append(startPnt)
        path.move(to: startPnt)
    }
    
    func addSegment(pos:CGPoint)
    {
        pnts.append(pos)
        numPnts += 1
        
        path.addLine(to: pos)
        path.closeSubpath()
        shapeNode.path = path
        
        
    }
    
    func update(pnt : CGPoint)
    {
        timer.poll(currTime:CFAbsoluteTimeGetCurrent())
        if (timer.timesUp())
        {
            timer.reset()
            addSegment(pos: pnt)
        }
    }
    
}
