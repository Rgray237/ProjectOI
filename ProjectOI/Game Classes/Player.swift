import Foundation


import Foundation


protocol  PlayerState
{
     func handleInput(plyr:Player,inp:Input)->PlayerState
    func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    func enter(plyr:Player,inp:Input,prevState:PlayerState)
}




class DamageState : PlayerState
{
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
        
    }
    
    
    func handleInput(plyr: Player, inp: Input) -> PlayerState {
        return DamageState()
    }
    
    func updateWithDelta(plyr: Player, delta: CFTimeInterval) {
        plyr.setVelocity(velocity: Vector3(Double.random(in: -5...5),Double.random(in: -5...5),Double.random(in: -5...5)))
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
        plyr.rot += plyr.w*delta
        plyr.calculateVertices()
        plyr.calculateAABB()
    }
    
    
}

class DyingState : PlayerState
{
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
        
    }
    
    func handleInput(plyr: Player, inp: Input) -> PlayerState {
        return DyingState()
    }
    
    func updateWithDelta(plyr: Player, delta: CFTimeInterval) {
        plyr.setVelocity(velocity: Vector3(0,0,0))
        plyr.renderNode.setScale(CGFloat(plyr.renderNode.scale*1.1))
    }
}


class IdleState : PlayerState
{
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
        plyr.setVelocity(velocity: plyr.vel * 0)
    }
    
   func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        if inp is Tap
        {
        return DashingState()
        }
        return IdleState()
    }

   func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
       plyr.pos.x += plyr.vel.x*delta
       plyr.pos.y += plyr.vel.y*delta
       plyr.pos.z += plyr.vel.z*delta
        plyr.rot += plyr.w*delta
        plyr.calculateVertices()
        plyr.calculateAABB()
    }
}

class DashingState1 : PlayerState
{
    var dashing1Timer = GameTimer(duration:0.1,descrip:"dashing1 timer")

    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
        plyr.setVelocity(velocity: plyr.vel * 2)
    }
    func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        
        return DashingState1()
    }

     func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
        plyr.rot += plyr.w*delta
        plyr.calculateVertices()
        plyr.calculateAABB()
        dashing1Timer.poll(currTime: CFAbsoluteTimeGetCurrent())

        if dashing1Timer.timesUp()
        {
            plyr.state = IdleState()
            plyr.state.enter(plyr: plyr, inp: NA(), prevState: self)
        }
        
    }
}

class DraggingState : PlayerState
{
    var dragPathUpdateTimer = GameTimer(duration: 0.1, descrip: "Dragtimer")
    
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
           //print ("Dashing")
           if let tap = inp as? Tap
           {
               let angle = Math2d().getAngleBtwnPoints(CGPoint(x: 0,y: 0), tap.tapPos)
           plyr.setVelocity(velocity: Vector3(plyr.dragSpeed * cos(angle), plyr.dragSpeed * sin(angle), 0))
           }
       }
    
    func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
        plyr.rot += plyr.w*delta
        plyr.calculateVertices()
        plyr.calculateAABB()
        dragPathUpdateTimer.poll(currTime: CFAbsoluteTimeGetCurrent())

        if dragPathUpdateTimer.timesUp()
        {
            plyr.addToDragPath(curPos:plyr.pos)
            dragPathUpdateTimer.reset()
        }
    }
    
    func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        if let tap = inp as? Tap
        {
        let angle = Math2d().getAngleBtwnPoints(CGPoint(x: 0,y: 0), tap.tapPos)
        plyr.setVelocity(velocity: Vector3(plyr.dragSpeed * cos(angle), plyr.dragSpeed * sin(angle), 0))
        }
        return DraggingState()
            
    }

}

class DashingState : PlayerState
{
    var dashingTimer = GameTimer(duration:0.05,descrip:"dashing timer")
    
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
        //print ("Dashing")
        if let tap = inp as? Tap
        {
            let angle = Math2d().getAngleBtwnPoints(CGPoint(x: 0,y: 0), tap.tapPos)
        plyr.setVelocity(velocity: Vector3(plyr.dashSpeed * cos(angle), plyr.dashSpeed * sin(angle), 0))
        }
    }
    
     func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        
        return DashingState()
    }

     func updateWithDelta(plyr:Player, delta:CFTimeInterval)
    {
        plyr.pos.x += plyr.vel.x*delta
        plyr.pos.y += plyr.vel.y*delta
        plyr.pos.z += plyr.vel.z*delta
        plyr.rot += plyr.w*delta
        plyr.calculateVertices()
        plyr.calculateAABB()
        dashingTimer.poll(currTime: CFAbsoluteTimeGetCurrent())

        if dashingTimer.timesUp()
        {
            plyr.state = DashingState1()
            plyr.state.enter(plyr: plyr, inp: NA(), prevState: self)
                
        }
        
    }
}

class CooldownState : PlayerState
{
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
        
    }
    
    func enter(plyr: Player,inp:Input) {
        
    }
    
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
    internal var dragSpeed:Double = 2
    internal var draggingConnection:Bool = false
    internal var pntDragged:ConnectPoint?
    internal var dragPath:DraggingPath?
    
    override init() {
        super.init()
        let settings = GameSettings()
        dynamic = true
        dashSpeed = settings.getPlayerSpeed()
        self.size = settings.getPlayerSize()
        calculateVertices()
        calculateAABB()
    }

    init (settings: GameSettings)
    {
        super.init()
        dynamic = true
        dashSpeed = settings.getPlayerSpeed()
        self.size = settings.getPlayerSize()
        calculateVertices()
        calculateAABB()
    }
    
    func handleInput(inp:Input)
    {
        let previousState = state
        state = state.handleInput(plyr: self, inp: inp)
        if (type(of: state) != type(of: previousState))
        {
            state.enter(plyr: self,inp:inp,prevState:previousState)
        }
    }

    func touchesConnectPoint(pnt:ConnectPoint)
    {
        if let draggedPnt = pntDragged{
        if pnt != draggedPnt
        {
            pnt.connectToPoint(pnt: draggedPnt)
        }
        }
        
        else
        {
            startDraggingConnection(pnt: pnt)
        }
    }
    
    func startDraggingConnection(pnt:ConnectPoint)
    {
        draggingConnection = true
        pntDragged = pnt
        self.state = DraggingState()
        var pth = CGMutablePath()
        pth.move(to: pnt.pos.toCGPoint2D())
        pth.addLine(to: pnt.pos.toCGPoint2D())
        dragPath = DraggingPath(path: pth)
    }
    
    func addToDragPath(curPos:Vector3)
    {
        let pth = CGMutablePath()
        if let drgPth = dragPath
        {
            pth.addPath(drgPth.path!)
            pth.addLine(to: curPos.toCGPoint2D())
        
        dragPath = DraggingPath(path: pth)
        }
    }
    
    
    override func updateWithDelta(delta: CFTimeInterval) {
        if (self.isDead())
        {
        self.state = DyingState()
        }
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
    
    func setState(state:PlayerState)
    {
        self.state = state
    }
    
}
