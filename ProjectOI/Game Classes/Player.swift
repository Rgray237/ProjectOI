import Foundation


import Foundation

class Input
{

}

protocol  PlayerState
{
    static func handleInput(plyr:Player,in:Input)
    static func update(plyr:Player)
}

class IdleState : PlayerState
{
   static func handleInput(plyr:Player,in:Input)
    {
    }

   static func update(plyr:Player)
    {
    }
}

class DashingState : PlayerState
{
    static func handleInput(plyr:Player,in:Input)
    {
    }

    static func update(plyr:Player)
    {
    }
}

class CooldownState : PlayerState
{
    static func handleInput(plyr:Player,in:Input)
    {
    }

    static func update(plyr:Player)
    {
    }
}



class Player : SentientActor
{

    internal var state:PlayerState

    init() {
        state = IdleState()
    }

    func changeState()
    {
        state = DashingState()
    }

    func getState()
    {
        if state is IdleState
        {
            print("idle")
        }

        if state is DashingState
        {
            print("dashing")
        }

    }
    
}

let plr = Player()
plr.getState()
plr.changeState()
plr.getState()
