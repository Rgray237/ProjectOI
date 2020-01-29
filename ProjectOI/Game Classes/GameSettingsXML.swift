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

    internal var PlayerSpeed : Double = 0
    internal var ShowFPS : Bool = false
    
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
        }
    }
    
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
       
        if elementName == "PlayerSpeed" {
                if let plySpd = Double(strPlayerSpeed)
                {
                    PlayerSpeed = plySpd
                }
               }
        
        if elementName == "ShowFPS"
        {
            if let showfps = strShowFPS == "1" ? true : false
            {
                ShowFPS = showfps
            }
        }
    }
    
    
    
}
