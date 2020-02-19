//
//  GameTime.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/26/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation


class GameTimer
{
    var startTime : CFTimeInterval = 0
    var timeRemaining : CFTimeInterval = 0
    private var isTimeUp : Bool = false
    var scheduledDuration : CFTimeInterval = 0
    var timerDescription : String = ""
    
    init(duration:CFTimeInterval, descrip:String)
    {
        startTime = CFAbsoluteTimeGetCurrent()
        scheduledDuration = duration
        timerDescription = descrip
        timeRemaining = duration
    }
    
    
    func poll(currTime:CFTimeInterval)
    {
        timeRemaining = scheduledDuration - (currTime - startTime)
        
        if (timeRemaining <= 0)
        {
            isTimeUp = true
        }
    }
    
    func reset()
    {
        startTime = CFAbsoluteTimeGetCurrent()
        timeRemaining = scheduledDuration
        isTimeUp = false
    }
    
    func timesUp()->Bool
    {
        return isTimeUp
    }
}
