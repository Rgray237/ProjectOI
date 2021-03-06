//
//  MainViewController.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/7/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import UIKit
import SpriteKit


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        let gameScene = GameScene(size: view.bounds.size)
        gameScene.scaleMode = .resizeFill
        gameScene.backgroundColor = UIColor.lightGray
        
        //gameScene.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        print(gameScene.size)
        
        let lvlMngr = LevelManager(scene:gameScene,view:skView)//LevelManager(lvl:1,scene:gameScene, view:skView)
        lvlMngr.loadLevel(lvl: 1)
        //lvlMngr.dotherest()
        skView.presentScene(gameScene)
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
