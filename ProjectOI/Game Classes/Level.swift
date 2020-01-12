//
//  Level.swift
//  ProjectOI
//
//  Created by Robert Gray on 12/8/19.
//  Copyright © 2019 Robert Gray. All rights reserved.
//

import Foundation


class Level
{
    var numBasicEnemies = 1
    var numPhases = 1
    var bookTitle: String = "blank"
    var bookAuthor: String = "blank"
    var enemiesInLevel: [Enemy] = []
    
    
    init (enemies:[Enemy])
    {
        for enemy in enemies
        {
            enemiesInLevel.append(enemy)
        }
    }
    
    init ()
    {
        
    }
}
