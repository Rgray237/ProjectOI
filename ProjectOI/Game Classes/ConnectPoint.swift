//
//  ConnectPoint.swift
//  ProjectOI
//
//  Created by Robert Gray on 2/16/20.
//  Copyright © 2020 Robert Gray. All rights reserved.
//

import Foundation

class ConnectPoint : GameObject , Equatable
{
    static func == (lhs: ConnectPoint, rhs: ConnectPoint) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    var ID:Int = 0
    var dragging:Bool = false
    internal var connected:Bool = false
    internal var cnctdPnt:ConnectPoint?
    
    init(id:Int)
    {
        super.init()
        ID = id
    }
    
    init(id:Int,position:Vector3)
    {
        super.init(position: position, dynamic: false)
        ID = id
    }
    
    func startedDragging()
    {
        dragging = true
    }
    
    func dropped()
    {
        dragging = false
        
    }
    
    func isOpen()->Bool
    {
        if dragging || connected
        {
            return false
        }
        return true
    }
    
    func isClosed()->Bool
    {
        if dragging || connected
        {
            return true
        }
        return false
    }
    
    func playerContacts()
    {
        if !isConnected()
        {
            startedDragging()
        }
    }
    
    func isConnected()->Bool
    {
        return connected
    }
    
    func connectToPoint(pnt:ConnectPoint)
    {
        connected = true
        dragging = false
        pnt.connected = true
        pnt.dragging = false
        renderNode.alpha = 1
        pnt.renderNode.alpha = 1
        cnctdPnt = pnt
        pnt.cnctdPnt = self
    }
    
    func getConnectedPoint()->ConnectPoint?
    {
        if let PNT = cnctdPnt as? ConnectPoint
        {
            return PNT
        }
        return nil
    }
}
