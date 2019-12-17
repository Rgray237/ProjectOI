//
//  GameSceneViewController.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/14/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import UIKit
import Metal


class GameSceneViewController: UIViewController {

    var device: MTLDevice!
    var metalLayer: CAMetalLayer!
    var pipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    var timer: CADisplayLink!
    var projectionMatrix: Matrix4!
    var lastFrameTimestamp: CFTimeInterval = 0.0

    
   var objectToDraw: Cube!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectionMatrix = Matrix4.makePerspectiveViewAngle(Matrix4.degrees(toRad: 85.0), aspectRatio: Float(self.view.bounds.size.width / self.view.bounds.size.height), nearZ: 0.01, farZ: 100.0)


        // Do any additional setup after loading the view.
        device = MTLCreateSystemDefaultDevice()
        metalLayer = CAMetalLayer()          // 1
        metalLayer.device = device           // 2
        metalLayer.pixelFormat = .bgra8Unorm // 3
        metalLayer.framebufferOnly = true    // 4
        metalLayer.frame = view.layer.frame  // 5
        view.layer.addSublayer(metalLayer)   // 6
        
        objectToDraw = Cube(device: device, commandQ: commandQueue)
       
        


        
        // 1
        let defaultLibrary = device.makeDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
            
        // 2
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            
        // 3
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)

        commandQueue = device.makeCommandQueue()
        timer = CADisplayLink(target: self, selector: #selector(GameSceneViewController.newFrame(displayLink:)))
        
        timer.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func render() {
      guard let drawable = metalLayer?.nextDrawable() else { return }
      let worldModelMatrix = Matrix4()
      worldModelMatrix.translate(0.0, y: 0.0, z: -7.0)
      worldModelMatrix.rotateAroundX(Matrix4.degrees(toRad: 25), y: 0.0, z: 0.0)

      objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, parentModelViewMatrix: worldModelMatrix, projectionMatrix: projectionMatrix ,clearColor: nil)
    }

    // 1
    @objc func newFrame(displayLink: CADisplayLink){
        
      if lastFrameTimestamp == 0.0
      {
        lastFrameTimestamp = displayLink.timestamp
      }
        
      // 2
      let elapsed: CFTimeInterval = displayLink.timestamp - lastFrameTimestamp
      lastFrameTimestamp = displayLink.timestamp
        
      // 3
      gameloop(timeSinceLastUpdate: elapsed)
    }
      
    func gameloop(timeSinceLastUpdate: CFTimeInterval) {
        
      // 4
      objectToDraw.updateWithDelta(delta: timeSinceLastUpdate)
        
      // 5
      autoreleasepool {
        self.render()
      }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
