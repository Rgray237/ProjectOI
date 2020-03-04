//
//  GOAnimation.swift
//  ProjectOI
//
//  Created by Robert Gray on 3/2/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class GOAnimation
{
    var animNodes:[Node]
    var animIntervalMS:Double
    var currNode:Node
    var currNodeIndex:Int
    var timer:GameTimer
    var ndCnt:Int
    
    init(arrNodes:[Node],intervalMS:Double) {
        animNodes = arrNodes
        animIntervalMS = intervalMS
        currNodeIndex = 0
        currNode = arrNodes[currNodeIndex]
        timer = GameTimer(duration: intervalMS/1000.0, descrip: "time between node change")
        ndCnt = arrNodes.count
    }
    
    func currentNode()->Node
    {
        return currNode
    }
    
    func nextNode()
    {
        timer.reset()
        currNode.alpha = 0
        currNodeIndex += 1
        
        if (currNodeIndex >= ndCnt)
        {
            currNodeIndex = 0
        }
        currNode = animNodes[currNodeIndex]
        currNode.alpha = 1
    }
    
    func update(pnt:CGPoint)
    {
        
        timer.poll(currTime: CFAbsoluteTimeGetCurrent())
        if (timer.timesUp())
        {
            nextNode()
        }
        //currNode.position = pnt
    }
    
}
