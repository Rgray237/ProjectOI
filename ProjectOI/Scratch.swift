import Foundation


struct Position
{
    var x : Float = 0
    var y : Float = 0
    var z : Float = 0
}

struct Rotation
{
    var x : Float = 0
    var y : Float = 0
    var z : Float = 0
}

struct Scale
{
    var x : Float = 1
    var y : Float = 1
    var z : Float = 1
}

class Transform
{
    var position = Position(x:0,y:0,z:0)
    var rotation = Rotation(x:0,y:0,z:0)
    var scale = Scale(x:1,y:1,z:1)
}

struct Velocity
{
    var x : Float = 0
    var y : Float = 0
    var z : Float = 0
}

class ScratchEnemy {
    var transform = Transform()
    var velocity = Velocity()
    
    func printDetails()
    {
        print("Position (x,y,z) = (\(transform.position.x),\(transform.position.y),\(transform.position.z))")
        print("Velocity (x,y,z) = (\(velocity.x),\(velocity.y),\(velocity.z))")
    }
    
    func updateTransform(msElapsed:Int)
    {
        transform.position.x = transform.position.x + (velocity.x)*Float(msElapsed)
        transform.position.y = transform.position.y + (velocity.y)*Float(msElapsed)
        transform.position.z = transform.position.z + (velocity.z)*Float(msElapsed)
    }
}
