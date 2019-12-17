//
//  ViewController.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/8/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAndPresentGameLevel(lvl: 1, parentViewController: self)
    }
    
    func loadAndPresentGameLevel(lvl: Int, parentViewController: UIViewController)
    {
        let lvlLoad = LevelLoader(lvl: lvl, parentViewController: parentViewController)
        lvlLoad.parseXMLFile()
        lvlLoad.dotherest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

