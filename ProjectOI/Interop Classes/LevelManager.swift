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

    
    
    
    init (lvl: Int, scene: GameScene, view:SKView)
    {
        gameWorld = scene.gameWorld
        super.init()
        chosenLevel = lvl
        mainGameView = view
        mainGameScene = scene
        parseXMLFile()

        //dotherest()
    }
    
    
    
    
    private func loadEverythingToGameWorld()
    {
        addPlayerCharacterToGameWorld()
        addEnemiesToGameWorld()
    }
    
    private func loadRenderObjects()
    {
        addGameWorldOrigin()
        addRenderNodesToPlayer()
        addRenderNodesToEnemies()

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
        gameWorld.addActor(actor: Player())
    }
    
    func addEnemiesToGameWorld()
    {
        for enmy in levels[chosenLevel].enemiesInLevel
        {
            enmy.printInfo()
            gameWorld.addActor(actor: enmy)
        }
    }
    
    func addGameWorldOrigin()
    {
        gameWorld.addObject(obj: gameWorld.origin)
        
        mainGameScene.addNodeToObject(renderNode: Node(imageNamed:"Origin.png"), obj: gameWorld.origin)
    }
    
    private func addRenderNodesToPlayer()
    {
        mainGameScene.addNodeToObject(renderNode: Node(imageNamed: "Player.png"), obj: gameWorld.getPlayer())
    }
    
    func addRenderNodesToEnemies()
    {
        for enmy in gameWorld.enemies
        {
            mainGameScene.addNodeToObject(renderNode: Node(imageNamed:"Odie.png"), obj: enmy)
            enmy.renderNode.setScale(0.2)
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
