

import UIKit

class MySceneViewController: MetalViewController,MetalViewControllerDelegate,UIGestureRecognizerDelegate {
  
  var worldModelMatrix:Matrix4!
  var objectToDraw: Cube!
  var gameWorld: GameWorld!
  let panSensivity:Float = 5.0
  var lastPanLocation: CGPoint!
    var curObj:Int = 0
    var cube1: Cube!
    var cube2: Cube!
    var metalBuff: MTLBuffer!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    worldModelMatrix = Matrix4()
    worldModelMatrix.translate(0.0, y: 0.0, z: -9)
    worldModelMatrix.rotateAroundX(Matrix4.degrees(toRad: 90), y: 0.0, z: 0.0)
    
    gameWorld = GameWorld()
    gameWorld.addActor(actor: Player())
    //gameWorld.addActor(actor: Enemy(Type: "basic", X: "3", Y: "4", ID: "1"))
    gameWorld.addActor(actor: Player())
    gameWorld.getActorAtIndex(index: 1)?.moveBy(vec: Vector3(5, 10, 0))
    
     cube1 = Cube(device: device, commandQ: commandQueue)
     cube2 = Cube(device: device, commandQ: commandQueue)
    
    //gameWorld.addNodeToObjectAtIndex(index: 0, renderNode: cube1)
    //gameWorld.addNodeToObjectAtIndex(index: 1, renderNode: cube2)

    
    objectToDraw = Cube(device: device, commandQ: commandQueue)
    self.metalViewControllerDelegate = self
    setupGestures()
  }
  
  //MARK: - MetalViewControllerDelegate
  func renderObjects(drawable:CAMetalDrawable) {
   
    if (curObj == 0)
    {
        objectToDraw = cube1
        curObj = 1
    }
    else
    {
        objectToDraw = cube2
        curObj = 0
    }
     
    objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, parentModelViewMatrix: worldModelMatrix, projectionMatrix: projectionMatrix, clearColor: nil)
    
  }
  
  func updateLogic(timeSinceLastUpdate: CFTimeInterval) {
    objectToDraw.updateWithDelta(delta: timeSinceLastUpdate)
  }
    
    //MARK: - Gesture related
    // 1
    func setupGestures(){
      let pan = UIPanGestureRecognizer(target: self, action: #selector(MySceneViewController.pan))
      self.view.addGestureRecognizer(pan)
    }
      
    // 2
    @objc func pan(panGesture: UIPanGestureRecognizer){
      if panGesture.state == UIGestureRecognizer.State.changed {
        let pointInView = panGesture.location(in: self.view)
        // 3
        let xDelta = Float((lastPanLocation.x - pointInView.x)/self.view.bounds.width) * panSensivity
        let yDelta = Float((lastPanLocation.y - pointInView.y)/self.view.bounds.height) * panSensivity
        // 4
        cube1.rotationY -= xDelta
        cube1.rotationX -= yDelta
        lastPanLocation = pointInView
      } else if panGesture.state == UIGestureRecognizer.State.began {
        lastPanLocation = panGesture.location(in: self.view)
      }
    }

  
  
}
