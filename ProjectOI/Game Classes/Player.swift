import Foundation


import Foundation


protocol  PlayerState
{
     func handleInput(plyr:Player,inp:Input)->PlayerState
    func updateWithDelta(plyr:Player, delta:CFTimeInterval)
}




class IdleState : PlayerState
{
   func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        if let tap = inp as? Tap
        {
            //print ("Dashing")
            plyr.setVelocity(velocity: Vector3(Double(tap.tapPos.x)*plyr.dashSpeed, Double(tap.tapPos.y)*plyr.dashSpeed, 0))
            plyr.timer = GameTimer(duration:0.25, descrip:"dashing timer")
        return DashingState()
        }
        return IdleState()
    }

   func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
       plyr.pos.x += plyr.vel.x*delta
       plyr.pos.y += plyr.vel.y*delta
       plyr.pos.z += plyr.vel.z*delta
    }
}

class DashingState1 : PlayerState
{
    func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        
        return DashingState1()
    }

     func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
        if let tmr = plyr.timer
        {
            tmr.poll(currTime: CFAbsoluteTimeGetCurrent())

            if tmr.timesUp()
            {
            //print("Idling")
            plyr.setVelocity(velocity: plyr.vel * 0)
            plyr.state = IdleState()
            }
        }
    }
}

class DashingState : PlayerState
{
    
     func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        
        return DashingState()
    }

     func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
        if let tmr = plyr.timer
        {
            tmr.poll(currTime: CFAbsoluteTimeGetCurrent())

            if tmr.timesUp()
            {
                plyr.timer = GameTimer(duration: 0.25, descrip: "Dashing1")
                plyr.setVelocity(velocity: plyr.vel * 0.5)
            plyr.state = DashingState1()
            }
        }
    }
}

class CooldownState : PlayerState
{
     func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        return DashingState()
    }

     func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
    }
}



class Player : SentientActor
{

    internal var state:PlayerState = IdleState()
    internal var timer:GameTimer?
    internal var dashSpeed:Double = 5
    
    override init() {
        super.init()
        dashSpeed = GameSettings().getPlayerSpeed()
    }

    
    
    func handleInput(inp:Input)
    {
        state = state.handleInput(plyr: self, inp: inp)
    }

    
    
    override func updateWithDelta(delta: CFTimeInterval) {
        state.updateWithDelta(plyr: self, delta: delta)
    }
    
    func getState()->String
    {
        if state is IdleState
        {
            return "idle"
        }

        if state is DashingState
        {
            return "dashing"
        }
        return "none"
    }
    
}
