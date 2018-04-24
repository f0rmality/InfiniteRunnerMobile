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
    var gameState = GameState.ready {
        willSet{
            switch newValue {
            case .playing:
                player.currentState = .running
                pauseEnemies(bool: false)
            case .finished:
                player.currentState = .idle
                pauseEnemies(bool: true)
            default:
                break
            }
        }
    }
    var player: Player!
    var bTouch = false
    var bBrake = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -7.0)
        
        //a kill line, eg death if you fall below a certain point
        physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: frame.minX, y: frame.minY), to: CGPoint(x: frame.maxX, y: frame.minY))
        physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.frameCategory
        physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.playerCategory
        
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
    
    //function to manually load levels and attach them to the world layer
    func load(level: String){
        if let levelNode = SKNode.unarchiveFromFile(file: level){
            mapNode = levelNode
            worldLayer.addChild(mapNode)
            
            loadTileMap()
        }
    }
    
    //properly load and scale the tilemaps to the screen, add player at the end
    func loadTileMap(){
        //unpause the map, swift has it set to true by default (stupid IMO)
        mapNode.isPaused = false
        
        if let groundTiles = mapNode.childNode(withName: GameConstants.StringConstants.groundTilesName) as? SKTileMapNode{
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
            
            //if the tile is a ground tile, add physics body to it
            PhysicsHelper.addPhysicsBody(to: tileMap, and: "ground")
            
            //all named children of the scene go through the object helper
            for child in groundTiles.children{
                if let sprite = child as? SKSpriteNode, sprite.name != nil{
                    ObjectHelper.handleChild(sprite: sprite, with: sprite.name!)
                }
            }
        }
        
        addPlayer()
        
    }
    
    //initialize the player including physics, scale, position, animation etc
    func addPlayer(){
        player = Player(imageNamed: GameConstants.StringConstants.playerImageName)
        player.scale(to: frame.size, width: false, multiplier: 0.1)
        player.name = GameConstants.StringConstants.playerName
        PhysicsHelper.addPhysicsBody(to: player, with: player.name!)
        player.position = CGPoint(x: frame.midX / 2.0, y: frame.midY)
        player.zPosition = GameConstants.ZPositions.playerZ
        player.loadTextures()
        player.currentState = .idle
        addChild(player)
        
        addPlayerActions()
    }
    
    func addPlayerActions(){
        let up = SKAction.moveBy(x: 0.0, y: frame.size.height/4, duration: 0.4)
        up.timingMode = .easeOut
        
        player.createUserData(entry: up, forKey: GameConstants.StringConstants.jumpUpActionKey)
        
        //group animation action and movement action together for the 'brake'
        let move = SKAction.moveBy(x: 0.0, y: player.size.height, duration: 0.4)
        let jump = SKAction.animate(with: player.jumpFrames, timePerFrame: 0.4/Double(player.jumpFrames.count))
        let group = SKAction.group([move, jump])
        
        player.createUserData(entry: group, forKey: GameConstants.StringConstants.brakeDescendActionKey)
    }
    
    func jump(){
        player.bAirborne = true
        player.turnGravity(on: false)
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
            if self.bTouch{
                //allow for double jump
                self.player.run(self.player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction, completion: {
                    self.turnGravity(on: true)
                })
            }
        }
    }
    
    func brakeDescend(){
        bBrake = true
        
        player.physicsBody?.velocity.dy = 0.0
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.brakeDescendActionKey) as! SKAction)
    }
    
    func handleEnemyContact(){
        death(cause: 0)
    }
    
    func pauseEnemies(bool: Bool){
        for enemy in tileMap[GameConstants.StringConstants.enemyName]{
            enemy.isPaused = bool
        }
    }
    
    func death(cause: Int){
        gameState = .finished
        player.turnGravity(on: false)
        
        let deathAnim: SKAction!
        
        switch cause {
            
            //death by enemy
        case 0:
            deathAnim = SKAction.animate(with: player.deathFrames, timePerFrame: 0.1, resize: true, restore: true)
            
            //death by falling (mario style)
        case 1:
            let up = SKAction.moveTo(y: frame.midY, duration: 0.25)
            let wait = SKAction.wait(forDuration: 0.1)
            let down = SKAction.moveTo(y: -player.size.height, duration: 0.2)
            
            deathAnim = SKAction.sequence([up, wait, down])
        default:
            deathAnim = SKAction.animate(with: player.deathFrames, timePerFrame: 0.1, resize: true, restore: true)
        }
        
        player.run(deathAnim) {
            self.player.removeFromParent()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .ready:
            gameState = .playing
        case.playing:
            bTouch = true
            if !player.bAirborne{
                jump()
            }
            
            else if !bBrake{
                brakeDescend()
            }
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.turnGravity(on: true)
        bTouch = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.turnGravity(on: true)
        bTouch = false
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
    
    override func didSimulatePhysics() {
        
        //activate the physics bodys if the player is above them (this way the player can still jump through platforms from below)
        //this thing is crazy useful btw, iterating through the map searching for the parameters
        
        for node in tileMap[GameConstants.StringConstants.groundNodeName]{
            if let groundNode = node as? GroundNode{
                let groundY = (groundNode.position.y + groundNode.size.height) * tileMap.yScale
                let playerY = player.position.y - player.size.height/3
                
                groundNode.bIsBodyActivated = playerY > groundY
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
            
            //player hits ground
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.bAirborne = false
            bBrake = false
            
            //player reaches the end
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.finishCategory:
            gameState = .finished
          
            //player hits enemy
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.enemyCategory:
            handleEnemyContact()
            
            //player falls to death
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.frameCategory:
            //this line is to prevent a loop
            physicsBody = nil
            death(cause: 1)
            
        default:
            break
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch contactMask {
            
            //player walks off ledge
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.bAirborne = true
            
        default:
            break
        }
    }
}
