//
//  Node.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/8/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation
import SpriteKit

class Node : SKSpriteNode
{
    
    var positionX: CGFloat = 0.0
    var positionY: CGFloat = 0.0

    var rotationX: CGFloat = 0.0
    var rotationY: CGFloat = 0.0
    var scale: Float     = 1.0
    
    
    init(imageNamed: String)
    {
        let texture = SKTexture(imageNamed: "Odie.png")
        super.init(texture: texture, color: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1), size: texture.size())        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
