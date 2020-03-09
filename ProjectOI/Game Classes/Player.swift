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
        //print("Idle")
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
        //print("dashing 1")
    }
    func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        if dashing1Timer.timesUp()
        {
            return IdleState()
        }
        else
        {
            return plyr.state
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
        dashing1Timer.poll(currTime: CFAbsoluteTimeGetCurrent())

        if dashing1Timer.timesUp()
        {
            plyr.state = IdleState()
            plyr.state.enter(plyr: plyr, inp: NA(), prevState: self)
        }
        
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
        //print(inp)
        //print(dashingTimer.timeRemaining)
        if (dashingTimer.timesUp())
        {
            return DashingState1()
        }
        else
        {
            return plyr.state
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
        dashingTimer.poll(currTime: CFAbsoluteTimeGetCurrent())

        if dashingTimer.timesUp()
        {
            plyr.state = DashingState1()
            plyr.state.enter(plyr: plyr, inp: NA(), prevState: self)
                
        }
        
    }
}


class DraggingState : PlayerState
{
    var dragPathUpdateTimer = GameTimer(duration: 0.1, descrip: "Dragtimer")
    
    func enter(plyr: Player, inp: Input, prevState: PlayerState) {
           print ("dragging")
            
        let angle = Math2d().getAngleOfVector(plyr.vel)
        plyr.setVelocity(velocity: Vector3(plyr.dragSpeed * cos(angle), plyr.dragSpeed * sin(angle), 0))
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

    }
    
    func handleInput(plyr:Player,inp:Input)->PlayerState
    {
        if let tap = inp as? Tap
        {
        let angle = Math2d().getAngleBtwnPoints(CGPoint(x: 0,y: 0), tap.tapPos)
        plyr.setVelocity(velocity: Vector3(plyr.dragSpeed * cos(angle), plyr.dragSpeed * sin(angle), 0))
        }
        
        if let drag = inp as? Pan
        {
            let angle = Math2d().getAngleBtwnPoints(CGPoint(x: 0, y: 0), drag.curLocation)
            plyr.setVelocity(velocity: Vector3(plyr.dragSpeed * cos(angle), plyr.dragSpeed * sin(angle), 0))
        }
        return DraggingState()
            
    }

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////v//////////////////////////////////////////////////
/*
 //
 
 
 
 
 
 
 
 
 END PLAYERSTATES
 
 
 
 BEGIN PLAYER CLASS
 
 
 */






//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class Player : SentientActor
{

    internal var state:PlayerState = IdleState()
    internal var timer:GameTimer?
    internal var dashSpeed:Double = 5
    internal var dragSpeed:Double = 200
    internal var draggingConnection:Bool = false
    internal var pntDragged:ConnectPoint?
    internal var dragPath:DraggingPath?
    var animation:GOAnimation

    override init() {
        let nd1 = Node(imageNamed: "Guy1.png")
        let nd2 = Node(imageNamed: "Guy2.png")
        let nds = [nd1,nd2]
        animation = GOAnimation(arrNodes: nds, intervalMS: 100)
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
        let nd1 = Node(imageNamed: "Guy1.png")
        let nd2 = Node(imageNamed: "Guy2.png")
        let nds = [nd1,nd2]
        animation = GOAnimation(arrNodes: nds, intervalMS: 100)
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
        if pnt.isOpen()
        {
            pnt.connectToPoint(pnt: draggedPnt)
            self.state = IdleState()
            self.state.enter(plyr: self, inp: NA(), prevState: DraggingState())
        }
        }
        
        else if (pnt.isOpen())
        {
            startDraggingConnection(pnt: pnt)
        }
    }
    
    func startDraggingConnection(pnt:ConnectPoint)
    {
        draggingConnection = true
        pntDragged = pnt
        let prevstate = self.state
        self.state = DraggingState()
        self.state.enter(plyr: self, inp: NA() , prevState: prevstate)
        
        dragPath = DraggingPath(startPnt: pnt.pos.toCGPoint2D())
    }
    
    func addToDragPath(curPos:Vector3)
    {
    }
    
    
    override func updateWithDelta(delta: CFTimeInterval) {
        if (self.isDead())
        {
        self.state = DyingState()
        }
        state.updateWithDelta(plyr: self, delta: delta)
        animation.update(pnt: CGPoint(x: 0,y: 0))
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
