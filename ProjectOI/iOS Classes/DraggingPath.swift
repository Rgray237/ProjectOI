//
//  DraggingPath.swift
//  ProjectOI
//
//  Created by Robert Gray on 2/19/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation
import SpriteKit

class DraggingPath : GameShape
{
    var pnts : [CGPoint]
    var numPnts : Int
    var timer : GameTimer
    var interval : CFTimeInterval = 0.1
    var shapeNode : ShapeNode
    var path : CGMutablePath
    
    init(startPnt: CGPoint)
    {
        numPnts = 1
        pnts = []
        timer = GameTimer(duration: interval, descrip: "Time between segments added")
        path = CGMutablePath()
        let shape = ShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: -5, y: -5, width: 100, height: 100), cornerRadius: 1).cgPath
        shape.position = CGPoint(x:0,y:0)
        shape.fillColor = UIColor.red
        shape.strokeColor = UIColor.blue
        shape.lineWidth = 10
        shapeNode = shape
        super.init(position: Vector3(Double(startPnt.x),Double(startPnt.y),0))
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
