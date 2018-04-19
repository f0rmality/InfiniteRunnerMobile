//
//  GameScene.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-17.
//

import SpriteKit

enum GameState{
    case ready, playing, paused, finished
}

class GameScene: SKScene {
    
    //scene variables
    var worldLayer: Layer!
    var backgroundLayer: RepeatingLayer!
    var mapNode: SKNode!
    var tileMap: SKTileMapNode!
    
    //time variables
    var lastTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    //game variables
    var gameState = GameState.ready;
    
    override func didMove(to view: SKView) {
       createLayers()
    }
    
    //add layers to the scene, set velocity of the scene, load level from file
    func createLayers(){
        worldLayer = Layer()
        worldLayer.zPosition = GameConstants.ZPositions.worldZ
        addChild(worldLayer)
        worldLayer.layerVelocity = CGPoint(x: GameConstants.LayerSpeeds.worldSpeed, y: 0.0)
        
        backgroundLayer = RepeatingLayer()
        addChild(backgroundLayer)
        
        //to create two identical backgrounds for scrolling
        for i in 0...1{
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[0])
            backgroundImage.name = String(i)
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: 0.0 + CGFloat(i) * backgroundImage.size.width, y: 0.0)
            backgroundImage.zPosition = GameConstants.ZPositions.farBGZ
            backgroundLayer.addChild(backgroundImage)
        }
        
        backgroundLayer.layerVelocity = CGPoint(x: GameConstants.LayerSpeeds.backgroundSpeed, y: 0.0)
        
        load(level: "Level_0_1")
    }
    
    //function to manually load levels and attach to the world layer
    func load(level: String){
        if let levelNode = SKNode.unarchiveFromFile(file: level){
            mapNode = levelNode
            worldLayer.addChild(mapNode)
            
            loadTileMap()
        }
    }
    
    //properly load and scale the tilemaps to the screen
    func loadTileMap(){
        if let groundTiles = mapNode.childNode(withName: GameConstants.StringConstants.groundTilesName) as? SKTileMapNode{
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .ready:
            gameState = .playing
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastTime > 0{
            dt = currentTime - lastTime
        }
            
        else{
            dt = 0
        }
        
        lastTime = currentTime
        
        //only move the level if the game is being played
        if(gameState == .playing){
            worldLayer.update(dt)
            backgroundLayer.update(dt)
        }
    }
}
