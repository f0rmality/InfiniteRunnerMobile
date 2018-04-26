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
        case GameConstants.StringConstants.finishLineName, GameConstants.StringConstants.enemyName,
             _ where GameConstants.StringConstants.specialCollectibleNames.contains(name):
            PhysicsHelper.addPhysicsBody(to: sprite, with: name)
    
            
        //default will be used for collectibles since grids have a variety of names
        default:
            let component = name.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            
            if let rows = Int(component[0]), let columns = Int(component[1]){
                calculateGridWidth(rows: rows, columns: columns, parent: sprite)
            }
        }
    }
    
    static func calculateGridWidth(rows: Int, columns: Int, parent: SKSpriteNode){
        
        parent.color = UIColor.clear
        
        //iterate through grid to place a coin at each point
        for x in 0..<columns{
            for y in 0..<rows{
                let position = CGPoint(x: x, y: y)
                addCoin(to: parent, at: position, columns: columns)
            }
        }
    }
    
    static func addCoin(to parent: SKSpriteNode, at position: CGPoint, columns: Int){
        
        //create the coin
        let coin = SKSpriteNode(imageNamed: GameConstants.StringConstants.coinImageName)
        coin.size = CGSize(width: parent.size.width/CGFloat(columns), height: parent.size.width/CGFloat(columns))
        coin.name = GameConstants.StringConstants.coinName
        
        //position the coin in the grid
        coin.position = CGPoint(x: position.x * coin.size.width + coin.size.width/2, y: position.y * coin.size.height + coin.size.height/2)
        
        //animate
        let coinFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.coinAtlas), withName: GameConstants.StringConstants.coinPrefixKey)
        coin.run(SKAction.repeatForever(SKAction.animate(with: coinFrames, timePerFrame: 0.1)))
        
        //physics, add to scene
        PhysicsHelper.addPhysicsBody(to: coin, with: GameConstants.StringConstants.coinName)
        parent.addChild(coin)
        
    }
}
