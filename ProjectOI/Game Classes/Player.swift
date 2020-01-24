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
        if inp is Tap
        {
            print ("Dashing")
            plyr.setVelocity(velocity: plyr.vel*5)
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

class DashingState : PlayerState
{
     func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        if inp is Untap
        {
            print("Idling")
            plyr.setVelocity(velocity: plyr.vel * 0.2)
            return IdleState()
        }
        return DashingState()
    }

     func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
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

    override init() {
        super.init()
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
