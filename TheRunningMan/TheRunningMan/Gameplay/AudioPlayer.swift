//
//  AudioPlayer.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit

class AudioPlayer{
    
    let buttonSound = SKAction.playSoundFileNamed(GameConstants.StringConstants.buttonClickAudio, waitForCompletion: false)
    let coinSound = SKAction.playSoundFileNamed(GameConstants.StringConstants.coinCollectedAudio, waitForCompletion: false)
    let collectibleSound = SKAction.playSoundFileNamed(GameConstants.StringConstants.collectibleFoundAudio, waitForCompletion: false)
    let deathSound = SKAction.playSoundFileNamed(GameConstants.StringConstants.gameLoseAudio, waitForCompletion: false)
    let winSound = SKAction.playSoundFileNamed(GameConstants.StringConstants.gameWinAudio, waitForCompletion: false)
    let jumpSound = SKAction.playSoundFileNamed(GameConstants.StringConstants.playerJumpAudio, waitForCompletion: false)
    
}
