//
//  GameSettingsXML.swift
//  ProjectOI
//
//  Created by Robert Gray on 1/28/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class GameSettings : NSObject, XMLParserDelegate
{
    internal var elementName = String()
    internal var strPlayerSpeed = String()
    internal var strShowFPS = String()
    internal var strPlayerHeight = String()
    internal var strPlayerWidth = String()
    

    internal var PlayerSpeed : Double = 0
    internal var ShowFPS : Bool = false
    internal var PlayerHeight : Double = 0
    internal var PlayerWidth : Double = 0
    
    override init()
    {
        super.init()
        parseXMLFile(fileName: "GameSettings")
    }
    
    init(fileName:String)
    {
        super.init()
        parseXMLFile(fileName:fileName)
    }
    
    
    func getPlayerSpeed()->Double
    {
        return PlayerSpeed
    }
    
    func getShowFPS()->Bool
    {
        return ShowFPS
    }
    
    func getPlayerHeight()->Double
    {
        return PlayerHeight
    }
    
    func getPlayerWidth()->Double
    {
        return PlayerWidth
    }
    
    func getPlayerSize()->CGSize
    {
        return CGSize(width: PlayerWidth, height: PlayerHeight)
    }
    
    private func parseXMLFile(fileName:String) {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "PlayerSpeed"
        {
            strPlayerSpeed = String()
        }
        
        if elementName == "ShowFPS"
        {
            strShowFPS = String()
        }
        
        if elementName == "PlayerHeight"
        {
            strPlayerHeight = String()
        }
        
        if elementName == "PlayerWidth"
        {
            strPlayerWidth = String()
        }
        self.elementName = elementName
    }
    
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if self.elementName == "PlayerSpeed" {
                strPlayerSpeed += data
            }
            else if self.elementName == "ShowFPS"
            {
                strShowFPS += data
            }
            else if self.elementName == "PlayerHeight"
            {
                strPlayerHeight += data
            }
            else if self.elementName == "PlayerWidth"
            {
                strPlayerWidth += data
            }
        }
    }
    
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
       
        if elementName == "PlayerSpeed" {
                if let plySpd = Double(strPlayerSpeed)
                {
                    PlayerSpeed = plySpd
                }
               }
        
        else if elementName == "ShowFPS"
        {
            if let showfps = strShowFPS == "1" ? true : false
            {
                ShowFPS = showfps
            }
        }
        
        else if elementName == "PlayerHeight"
        {
            if let plyht = Double(strPlayerHeight)
            {
                PlayerHeight = plyht
            }
        }
        else if elementName == "PlayerWidth"
        {
            if let plywdth = Double(strPlayerWidth)
            {
                PlayerWidth = plywdth
            }
        }
    }
    
    
    
}
