

import UIKit

class MySceneViewController: MetalViewController,MetalViewControllerDelegate,UIGestureRecognizerDelegate {
  
  var worldModelMatrix:Matrix4!
  var objectToDraw: Cube!
  
  let panSensivity:Float = 5.0
  var lastPanLocation: CGPoint!

    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    worldModelMatrix = Matrix4()
    worldModelMatrix.translate(0.0, y: 0.0, z: -9)
    worldModelMatrix.rotateAroundX(Matrix4.degrees(toRad: 15), y: 0.0, z: 0.0)
    
    objectToDraw = Cube(device: device, commandQ: commandQueue)
    self.metalViewControllerDelegate = self
    setupGestures()
    
    

  }
  
  //MARK: - MetalViewControllerDelegate
  func renderObjects(drawable:CAMetalDrawable) {
    
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
      if panGesture.state == UIGestureRecognizerState.changed {
        let pointInView = panGesture.location(in: self.view)
        // 3
        let xDelta = Float((lastPanLocation.x - pointInView.x)/self.view.bounds.width) * panSensivity
        let yDelta = Float((lastPanLocation.y - pointInView.y)/self.view.bounds.height) * panSensivity
        // 4
        objectToDraw.rotationY -= xDelta
        objectToDraw.rotationX -= yDelta
        lastPanLocation = pointInView
      } else if panGesture.state == UIGestureRecognizerState.began {
        lastPanLocation = panGesture.location(in: self.view)
      }
    }

  
  
}