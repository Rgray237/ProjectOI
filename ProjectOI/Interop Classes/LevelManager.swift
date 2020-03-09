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


class LevelManager: NSObject, XMLParserDelegate
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

    
     var mainGameScene = GameScene()
    internal var mainGameView = SKView()
    internal var chosenLevel = Int()
    internal var llParentViewController = UIViewController()
    var gameWorld:GameWorld
    var gameSettings:GameSettings
    
    
    
    init (lvl: Int, scene: GameScene, view:SKView)
    {
        gameWorld = scene.gameWorld
        gameSettings = GameSettings(fileName: "GameSettings")
        super.init()
        chosenLevel = lvl
        mainGameView = view
        mainGameScene = scene
        parseXMLFile()
        gameWorld.lvlManger = self
        gameWorld.spriteScene = mainGameScene
        //dotherest()
    }
    
    init (scene: GameScene, view:SKView)
    {
        gameWorld = scene.gameWorld
        gameSettings = GameSettings(fileName: "GameSettings")
        super.init()
        mainGameView = view
        mainGameScene = scene
        gameWorld.lvlManger = self
        gameWorld.spriteScene = mainGameScene

    }
    
    func loadLevel(lvl:Int)
    {
        levels.removeAll()
        enemies.removeAll()
        mainGameScene.removeAllChildren()
        mainGameScene.gameWorld = GameWorld()
        gameWorld = mainGameScene.gameWorld
        gameWorld.lvlManger = self
        chosenLevel = lvl
        parseXMLFile()
        dotherest()
    }
    
    func reload()
    {
        levels.removeAll()
        enemies.removeAll()
        mainGameScene.removeAllChildren()
        mainGameScene.gameWorld = GameWorld()
        gameWorld = mainGameScene.gameWorld
        gameWorld.lvlManger = self
        parseXMLFile()
        dotherest()
    }
    
    func reset()
    {
        print("resetting")
    }
    
    
    private func loadEverythingToGameWorld()
    {
        addPlayerCharacterToGameWorld()
        addEnemiesToGameWorld()
        addWallsToGameWorld()
        addConnectPointsToGameWorld()
        addVectorGraphics()
    }
    
    func addVectorGraphics()
    {
        
        
    }
    
    private func loadRenderObjects()
    {
        addGameWorldOrigin()
        addRenderNodesToPlayer()
        addRenderNodesToEnemies()
        addRenderNodesToWalls()
        addRenderNodesToConnectPoints()
        addPlayerAnimationToScene()
        
    }
    
    func addPlayerAnimationToScene()
    {
        for nd in gameWorld.getPlayer().animation.animNodes {
            nd.setScale(0.2)
            mainGameScene.addChild(nd)
        }
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
        //addEnemiesToScene()
        loadEverythingToGameWorld()
        loadRenderObjects()
        setupCamera()
        
    }
    
    func setupCamera()
    {
        mainGameScene.setupCamera()
    }

    func addPlayerCharacterToGameWorld()
    {
        
        gameWorld.addActor(actor: Player(settings:gameSettings))
    }
    
    func addEnemiesToGameWorld()
    {
        for enmy in levels[chosenLevel].enemiesInLevel
        {
            //enmy.printInfo()
            //enmy.setState(state: nmeChasingState())
            gameWorld.addActor(actor: enmy)
        }
    }
    
    func addWallsToGameWorld()
    {
        let wall = Wall(position: Vector3(0,-100,0),dynamic: false)
        
        gameWorld.addWall(wall: wall)
        wall.size = CGSize(width: 100, height: 100)
        
    }
    
    func addConnectPointsToGameWorld()
    {
        let pnt = ConnectPoint(id:1,position: Vector3(200,0,0))
        
        gameWorld.addObject(obj: pnt)
        pnt.size = CGSize(width: 50, height: 50)
        let pnt2 = ConnectPoint(id:2,position: Vector3(0,200,0))
        gameWorld.addObject(obj: pnt2)
        pnt2.size = CGSize(width:50,height: 50)
    }
    
    func addGameWorldOrigin()
    {
        gameWorld.addObject(obj: gameWorld.origin)
        gameWorld.origin.size = CGSize(width:20,height:20)
        mainGameScene.addNodeToObject(renderNode: Node(imageNamed:"Origin.png"), obj: gameWorld.origin)
    }
    
    private func addRenderNodesToPlayer()
    {
        mainGameScene.addNodeToObject(renderNode: Node(imageNamed: "Guy1.png"), obj: gameWorld.getPlayer())
        gameWorld.player.renderNode.blendMode = .alpha
        gameWorld.player.renderNode.alpha = 0
    }
    
    func addRenderNodesToEnemies()
    {
        for enmy in gameWorld.enemies
        {
            mainGameScene.addNodeToObject(renderNode: Node(imageNamed:"Odie.png"), obj: enmy)
            enmy.renderNode.blendMode = .replace
        }
    }
    
    func addRenderNodesToWalls()
    {
        for wall in gameWorld.walls {
            mainGameScene.addNodeToObject(renderNode: Node(imageNamed:"Wall.png"), obj: wall)
            wall.renderNode.blendMode  = .alpha
        }
    }
    
    func addRenderNodesToConnectPoints()
    {
        for obj in gameWorld.gameObjects{
            if obj is ConnectPoint
            {
                mainGameScene.addNodeToObject(renderNode: Node(imageNamed:"ConnectPoint.png"), obj: obj)
                obj.renderNode.alpha = 0.5
            }
        }
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
            let enemy = Enemy(Type: 1, X: Double(enemyX)!, Y: Double(enemyY)!, ID: Int(enemyID)!)
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
