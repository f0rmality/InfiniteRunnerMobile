//
//  Layer.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-18.
//

import SpriteKit

//helper functions

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (left: inout CGPoint, right: CGPoint){
    left = left + right
}

class Layer: SKNode{
    
    var layerVelocity = CGPoint.zero
    
    //mass update for everything in layer
    func update(_ delta: TimeInterval){
        for child in children{
            updateNodesGlobal(delta, childNode: child)
        }
    }
    
    //the offset will allow us to move everything in the layer based on how much time has passed
    func updateNodesGlobal(_ delta: TimeInterval, childNode: SKNode){
        let offset = layerVelocity * CGFloat(delta)
        childNode.position += offset
        updateNodes(delta, childNode: childNode)
    }
    
    func updateNodes(_ delta: TimeInterval, childNode: SKNode){
        //overidden in child classes
    }
    
}
