//
//  PhysicsHelper.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-22.
//

import SpriteKit

class PhysicsHelper{
    static func addPhysicsBody(to sprite: SKSpriteNode, with name: String){
        
        switch name {
        case GameConstants.StringConstants.playerName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            sprite.physicsBody!.restitution = 0.0
            sprite.physicsBody!.allowsRotation = false
        default:
            //add basic physics body if no specifics
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        }
    }
    
    //this function is used to create platforms of physics bodies, instead of adding one to every single ground tile
    static func addPhysicsBody(to tileMap: SKTileMapNode, and tileInfo: String){
        let tileSize = tileMap.tileSize
        
        for row in 0..<tileMap.numberOfRows{
            var tiles = [Int]()
            
            for column in 0..<tileMap.numberOfColumns{
                let tileDefinition = tileMap.tileDefinition(atColumn: column, row: row)
                let isUsedTile = tileDefinition?.userData?[tileInfo] as? Bool
                
                //use 1s and 0s to write whether a tile is or isnt at the location
                if (isUsedTile ?? false){
                    tiles.append(1)
                }
                else{
                    tiles.append(0)
                }
            }
            
            if tiles.contains(1){
                var platform = [Int]()
                
                for(index, tile) in tiles.enumerated(){
                    if tile == 1 && index < (tileMap.numberOfColumns - 1){
                        platform.append(index)
                    }
                    
                    else if !platform.isEmpty{
                        let x = CGFloat(platform[0]) * tileSize.width
                        let y = CGFloat(row) * tileSize.height
                        let tileNode = GroundNode(with: CGSize(width: tileSize.width * CGFloat(platform.count), height: tileSize.height))
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.anchorPoint = CGPoint.zero
                        tileMap.addChild(tileNode)
                        platform.removeAll()
                    }
                    
                    
                }
            }
        }
    }
}
