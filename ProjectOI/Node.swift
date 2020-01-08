//
//  Node.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/8/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation
import SpriteKit

class Node : SKNode
{
    
    var positionX: CGFloat = 0.0
    var positionY: CGFloat = 0.0

    var rotationX: CGFloat = 0.0
    var rotationY: CGFloat = 0.0
    var scale: Float     = 1.0
    
    override init() {
        super.init()
        positionX = position.x
        positionY = position.y
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
