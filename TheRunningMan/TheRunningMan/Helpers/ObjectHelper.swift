//
//  ObjectHelper.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-24.
//

import SpriteKit

class ObjectHelper{
    
    static func handleChild(sprite: SKSpriteNode, with name: String){
        switch name {
        case GameConstants.StringConstants.finishLineName, GameConstants.StringConstants.enemyName:
            PhysicsHelper.addPhysicsBody(to: sprite, with: name)
        default:
            break
        }
    }
    
}
