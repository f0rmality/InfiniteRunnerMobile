//
//  GameScene.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-17.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var mapNode: SKNode!
    var tileMap: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        load(level: "Level_0_1")
       
    }
    
    //function to manually load levels
    func load(level: String){
        if let levelNode = SKNode.unarchiveFromFile(file: level){
            mapNode = levelNode
            addChild(mapNode)
            
            loadTileMap()
        }
    }
    
    //properly load and scale the tilemaps to the screen
    func loadTileMap(){
        if let groundTiles = mapNode.childNode(withName: "GroundTiles") as? SKTileMapNode{
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
