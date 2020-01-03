

import Foundation


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
    
    func isLoaded()->Bool
    {
        return loaded
    }
    
    func load()
    {
        loaded = true
    }
    
}
