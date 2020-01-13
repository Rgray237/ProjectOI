//
//  BufferProvider.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/16/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Metal


class BufferProvider : NSObject
{
    // 1
    let inflightBuffersCount: Int
    // 2
    private var uniformsBuffers: [MTLBuffer]
    // 3
    private var availableBufferIndex: Int = 0

    var availableResourcesSemaphore: DispatchSemaphore

    
    init(device:MTLDevice, inflightBuffersCount: Int, sizeOfUniformsBuffer: Int) {
        availableResourcesSemaphore = DispatchSemaphore(value: inflightBuffersCount)

        
      self.inflightBuffersCount = inflightBuffersCount
      uniformsBuffers = [MTLBuffer]()
        
      for _ in 0...inflightBuffersCount-1 {
        guard let uniformsBuffer = device.makeBuffer(length: sizeOfUniformsBuffer, options: []) else {return}
        uniformsBuffers.append(uniformsBuffer)
      }
    }
    
    deinit{
      for _ in 0...self.inflightBuffersCount{
        self.availableResourcesSemaphore.signal()
      }
    }

    
    func nextUniformsBuffer(projectionMatrix: Matrix4, modelViewMatrix: Matrix4) -> MTLBuffer {
        
      // 1
      let buffer = uniformsBuffers[availableBufferIndex]
        
      // 2
      let bufferPointer = buffer.contents()
        
      // 3
      memcpy(bufferPointer, modelViewMatrix.raw(), MemoryLayout<Float>.size * Matrix4.numberOfElements())
      memcpy(bufferPointer + MemoryLayout<Float>.size*Matrix4.numberOfElements(), projectionMatrix.raw(), MemoryLayout<Float>.size*Matrix4.numberOfElements())
        
      // 4
      availableBufferIndex += 1
      if availableBufferIndex == inflightBuffersCount{
        availableBufferIndex = 0
      }
        
      return buffer
    }

    

}
