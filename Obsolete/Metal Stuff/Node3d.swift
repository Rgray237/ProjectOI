//
//  Node.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/15/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation
import Metal
import QuartzCore

class Node3d {
  
  let device: MTLDevice
  let name: String
  var vertexCount: Int
  var vertexBuffer: MTLBuffer
    
    var positionX: Float = 0.0
    var positionY: Float = 0.0
    var positionZ: Float = 0.0

    var rotationX: Float = 0.0
    var rotationY: Float = 0.0
    var rotationZ: Float = 0.0
    var scale: Float     = 1.0
    var time:CFTimeInterval = 0.0
    var bufferProvider: BufferProvider
    var texture: MTLTexture
    lazy var samplerState: MTLSamplerState? = Node3d.defaultSampler(device: self.device)

  
  init(name: String, vertices: Array<Vertex>, device: MTLDevice, texture: MTLTexture) {
    // 1
    var vertexData = Array<Float>()
    for vertex in vertices{
      vertexData += vertex.floatBuffer()
    }
    
    // 2
    let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
    vertexBuffer = device.makeBuffer(bytes: vertexData, length: dataSize, options: [])!
    
    // 3
    self.name = name
    self.device = device
    vertexCount = vertices.count
    self.texture = texture

    self.bufferProvider = BufferProvider(device: device, inflightBuffersCount: 3, sizeOfUniformsBuffer: MemoryLayout<Float>.size * Matrix4.numberOfElements() * 2)

  }
    
    func render(commandQueue: MTLCommandQueue, pipelineState: MTLRenderPipelineState, drawable: CAMetalDrawable, parentModelViewMatrix: Matrix4, projectionMatrix: Matrix4, clearColor: MTLClearColor?) {

        _ = bufferProvider.availableResourcesSemaphore.wait(timeout: DispatchTime.distantFuture)

      let renderPassDescriptor = MTLRenderPassDescriptor()
      renderPassDescriptor.colorAttachments[0].texture = drawable.texture
      renderPassDescriptor.colorAttachments[0].loadAction = .clear
      renderPassDescriptor.colorAttachments[0].clearColor =
        MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
      renderPassDescriptor.colorAttachments[0].storeAction = .store

        guard let commandBuffer = commandQueue.makeCommandBuffer() else {return}

        commandBuffer.addCompletedHandler { (_) in
          self.bufferProvider.availableResourcesSemaphore.signal()
        }

        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {return}
        //For now cull mode is used instead of depth buffer
        renderEncoder.setCullMode(MTLCullMode.front)
      renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderEncoder.setFragmentTexture(texture, index: 0)
        if let samplerState = samplerState{
            renderEncoder.setFragmentSamplerState(samplerState, index: 0)
        }

        // 1
        let nodeModelMatrix = self.modelMatrix()
        nodeModelMatrix.multiplyLeft(parentModelViewMatrix)

        let uniformBuffer = bufferProvider.nextUniformsBuffer(projectionMatrix: projectionMatrix, modelViewMatrix: nodeModelMatrix)


        // 5
        renderEncoder.setVertexBuffer(uniformBuffer, offset: 0, index: 1)

      renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount,
        instanceCount: vertexCount/3)
      renderEncoder.endEncoding()

      commandBuffer.present(drawable)
      commandBuffer.commit()
    }

    func modelMatrix() -> Matrix4 {
        let matrix = Matrix4()
        matrix.translate(positionX, y: positionY, z: positionZ)
        matrix.rotateAroundX(rotationX, y: rotationY, z: rotationZ)
        matrix.scale(scale, y: scale, z: scale)
        return matrix
    }

 
    func updateWithDelta(delta: CFTimeInterval){
        time += delta
    }

    class func defaultSampler(device: MTLDevice) -> MTLSamplerState {
      let sampler = MTLSamplerDescriptor()
      sampler.minFilter             = MTLSamplerMinMagFilter.nearest
      sampler.magFilter             = MTLSamplerMinMagFilter.nearest
      sampler.mipFilter             = MTLSamplerMipFilter.nearest
      sampler.maxAnisotropy         = 1
      sampler.sAddressMode          = MTLSamplerAddressMode.clampToEdge
      sampler.tAddressMode          = MTLSamplerAddressMode.clampToEdge
      sampler.rAddressMode          = MTLSamplerAddressMode.clampToEdge
      sampler.normalizedCoordinates = true
      sampler.lodMinClamp           = 0
        sampler.lodMaxClamp           = Float.greatestFiniteMagnitude
        return device.makeSamplerState(descriptor: sampler)!
    }

    
    
}
