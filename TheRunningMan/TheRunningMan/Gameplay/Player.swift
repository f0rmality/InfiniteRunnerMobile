//
//  Player.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-19.
//

import SpriteKit

enum PlayerState{
    case idle, running
}

class Player: SKSpriteNode {

    var runFrames = [SKTexture]()
    var idleFrames = [SKTexture]()
    var jumpFrames = [SKTexture]()
    var deathFrames = [SKTexture]()
    
    var currentState = PlayerState.idle {
        willSet{
            animate(for: newValue)
        }
    }
    
    var bAirborne = false
    
    func loadTextures(){
        runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRunAtlas), withName: GameConstants.StringConstants.runPrefixKey)
        
        idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerIdleAtlas), withName: GameConstants.StringConstants.idlePrefixKey)
        
        jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerJumpAtlas), withName: GameConstants.StringConstants.jumpPrefixKey)
        
        deathFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDeathAtlas), withName: GameConstants.StringConstants.deathPrefixKey)
    }
    
    func animate(for state: PlayerState){
        
        removeAllActions()
        
        switch state {
        case .idle:
            self.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.05, resize: true, restore: true)))
        case .running:
            self.run(SKAction.repeatForever(SKAction.animate(with: runFrames, timePerFrame: 0.05, resize: true, restore: true)))
        }
        
    }
    
    
    
}
