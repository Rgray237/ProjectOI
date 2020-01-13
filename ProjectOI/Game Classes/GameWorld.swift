

import Foundation
import SpriteKit

class GameWorld
{
  //var objects:[GameObject]
  //var player: Player!
  //var enemies: [Enemy]
  //var obstacles: [Obstacle]
  //var neurons: [Neuron]
  //var portals: [Portal]
  //var planes: [Plane]
    internal var loaded:Bool = false
    internal var actors:[SentientActor] = []
    internal var gameObjects:[GameObject] = []
    internal var enemies:[Enemy] = []
    
    //Guarantee the following two arrays to have same array size.
    internal var renderObjects:[Node] = []
    internal var spriteScene:SKScene = SKScene()
    internal var player:Player = Player()
    
    func updateWithDelta(delta:CFTimeInterval)
    {
        for actor in actors {
            actor.updateWithDelta(delta: delta)
        }
    }

    
    func getNumActors()->Int
    {
        return actors.count
    }
    
    func addActor(actor: SentientActor)
    {
        if actor is Enemy
        {
            enemies.append(actor as! Enemy)
        }
        if actor is Player
        {
            player = actor as! Player
        }
        
        actors.append(actor)
        gameObjects.append(actor)
    }
    
    func getActorAtIndex(index:Int)->SentientActor?
    {
        if (index > actors.count-1)
        {
            return nil
        }
        else
        {
            return actors[index]
        }
        
    }
    
    
    func addNodeToObjectAtIndex(index:Int, renderNode:Node)
    {
        if (index > gameObjects.count-1)
        {
            return
        }
        
        gameObjects[index].addNode(node: renderNode)
        renderObjects.append(renderNode)
    }
    
    func getPlayer()->Player
    {
        return player
    }
    
}
