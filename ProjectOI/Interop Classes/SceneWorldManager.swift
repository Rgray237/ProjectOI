//
//  SceneWorldManager.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/12/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class SceneWorldManager
{
    internal var gameScene:GameScene
    internal var gameWorld:GameWorld
    
    init(scene:GameScene,world:GameWorld)
    {
        gameScene = scene
        gameWorld = world
        gameScene.gameWorld = world
    }
    
    func getWorld()->GameWorld
    {
        return gameWorld
    }
    
    func getScene()->GameScene
    {
        return gameScene
    }
}
