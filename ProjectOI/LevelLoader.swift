//
//  LevelLoader.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/8/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation
import SpriteKit
import GLKit


class LevelLoader: NSObject, XMLParserDelegate
{
    internal var levels: [Level] = []
    internal var elementName = String()
    internal var bookTitle = String()
    internal var bookAuthor = String()
    internal var enemies: [Enemy] = []
    internal var numEnemies = String()
    internal var enemyX = String()
    internal var enemyY = String()
    internal var enemyType = String()
    internal var enemyID:String = ""

    internal var mainGameScene = MySceneViewController()
    internal var mainGameView = UIView()
    internal var chosenLevel = Int()
    internal var llParentViewController = UIViewController()
    
    private var ebo = GLuint()//Element Buffer Object (EBO): Keeps track of the indices that define triangles, like the indices you have stored in the Indices array.

    private var vbo = GLuint()//Vertex Buffer Object (VBO): Keeps track of the per-vertex data itself, like the data you have in the Vertices array.
    private var vao = GLuint()//Vertex Array Object (VAO): This object can be bound like the vertex buffer object. Any future vertex attribute calls you make — after binding a vertex array object — will be stored inside it. What this means is that you only have to make calls to configure vertex attribute pointers once and then — whenever you want to draw an object — you bind the corresponding VAO. This facilitates and speeds up drawing different vertex data with different configurations.

    

    init(lvl: Int, parentViewController: UIViewController)
    {
        super.init()
        chosenLevel = lvl
        llParentViewController = parentViewController
        
        mainGameScene = setupGameScene()
        mainGameView = setupGameView()
        parseXMLFile()
    }
    
    
    private func parseXMLFile() {
        if let path = Bundle.main.url(forResource: "LEVELS", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    func dotherest()
    {
        addEnemiesToScene()

        
    }

    
    func numberOfEnemiesInScene()->Int
    {
        return 3
    }
    
    
    func addEnemiesToScene()
    {
        /*for enemy in levels[chosenLevel-1].enemiesInLevel
        {
            enemy.printInfo()
            
            let image = SKSpriteNode(imageNamed: "Odie.png")
            image.scale(to: CGSize(width: 50, height: 50))
            image.position = CGPoint (x: enemy.x, y: enemy.y)
            
            // Add the image to the scene.
            mainGameScene.addChild(image)
            
        }
 */
    }
    
    private func setupGameScene()->MySceneViewController
    {
        let scene = MySceneViewController()
        return scene
    }
    
    private func setupGameView()->UIView
    {
        
        let view = mainGameScene.view!
        return view
        
    }
    
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "lvl" {
            bookTitle = String()
            bookAuthor = String()
        }
        
        if elementName == "enemies" {
            numEnemies = String()
        }
        
        if elementName == "enemy"
        {
            enemyID = String()
            enemyType = String()
            enemyX = String()
            enemyY = String()
            
            if let id = attributeDict["id"]
            {
                enemyID = id
            }
            if let type = attributeDict["type"]
            {
                enemyType = type
            }
            if let x = attributeDict["x"]
            {
                enemyX = x
            }
            if let y = attributeDict["y"]
            {
                enemyY = y
            }
        }
        
        self.elementName = elementName
    }
    
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "lvl" {
            let level = Level(enemies: enemies)
            levels.append(level)
            enemies = []
        }
        
        if elementName == "enemy"
        {
            let enemy = Enemy(Type: enemyType, X: enemyX, Y: enemyY, ID:enemyID)
            enemies.append(enemy)
        }
    }
    
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }
    
}
