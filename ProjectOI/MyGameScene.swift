//
//  GameScene.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/8/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameScene: SKScene
{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scene = GameScene(size: view.bounds.size)
        
        // Set the scene coordinates (0, 0) to the center of the screen.
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let image = SKSpriteNode(imageNamed: "Odie.png")
        
        // Add the image to the scene.
        scene.addChild(image)
        
        if let skView = self.view as? SKView {
            skView.presentScene(scene)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
