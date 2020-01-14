import Foundation


import Foundation


protocol  PlayerState
{
     func handleInput(plyr:Player,in:Input)->PlayerState
     func update(plyr:Player)
}

class IdleState : PlayerState
{
   func handleInput(plyr:Player,in:Input)->PlayerState
    {
        return DashingState()
    }

   func update(plyr:Player)
    {
    }
}

class DashingState : PlayerState
{
     func handleInput(plyr:Player,in:Input)->PlayerState
    {
        return DashingState()
    }

     func update(plyr:Player)
    {
        plyr.setVelocity(velocity: plyr.vel*2)
    }
}

class CooldownState : PlayerState
{
     func handleInput(plyr:Player,in:Input)->PlayerState
    {
        return DashingState()
    }

     func update(plyr:Player)
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
        state = state.handleInput(plyr: self, in: inp)
    }

    override func update() {
        state.update(plyr: self)
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
