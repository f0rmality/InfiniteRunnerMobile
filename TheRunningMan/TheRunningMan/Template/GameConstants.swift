//
//  GameConstants.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-19.
//
//  this file will hold any constants ill be using throughout the game so that I don't have to keep track of as much info, or do as much hardcoding

import Foundation
import CoreGraphics

struct GameConstants{
    
    struct ZPositions{
        static let farBGZ: CGFloat = 0
        static let closeBGZ: CGFloat = 1
        static let worldZ: CGFloat = 2
        static let objectZ: CGFloat = 3
        static let playerZ: CGFloat = 4
        static let foregroundZ: CGFloat = 5
        static let HUDZ: CGFloat = 6
    }
    
    struct StringConstants{
        //misc
        static let gameName = "The Running Man"
        
        //scene stuff
        static let groundTilesName = "GroundTiles"
        static let worldBackgroundNames = ["scarybackground2", "citybackground1"]
        static let foregroundName = "Foreground"
        static let playerName = "Player"
        static let playerImageName = "Idle_0"
        static let groundNodeName = "GroundNode"
        static let finishLineName = "FinishLine"
        static let enemyName = "Enemy"
        static let coinName = "Coin"
        static let coinImageName = "gold0"
        static let specialCollectibleImageName = "skull1"
        static let specialCollectibleNames = ["Special1", "Special2", "Special3"]
        
        //UI stuff
        static let gameFontName = "Mrs. Monster Regular"
        static let playButton = "PlayButton"
        static let menuButton = "MenuButton"
        static let retryButton = "RestartButton"
        static let cancelButton = "CancelButton"
        static let pauseButton = "PauseButton"
        static let emptyButton = "EmptyButton"
        static let largePopup = "PopupLarge"
        static let smallPopup = "PopupSmall"
        static let emptyStar = "EmptyStar"
        static let fullStar = "FullStar"
        static let banner = "Banner"
        static let popupButtonNames = ["MenuButton", "PlayButton", "RestartButton", "CancelButton"]
        static let pausedKey = "Paused"
        static let completedKey = "Completed"
        static let failedKey = "Failed"
        
        //score info
        static let scoreScoreKey = "score"
        static let scoreCollectiblesKey = "collectibles"
        static let scoreStarsKey = "stars"
        
        //animation stuff
        static let playerIdleAtlas = "PlayerIdle"
        static let playerJumpAtlas = "PlayerJump"
        static let playerDeathAtlas = "PlayerDie"
        static let playerRunAtlas = "PlayerRun"
        static let idlePrefixKey = "Idle_"
        static let deathPrefixKey = "Die_"
        static let runPrefixKey = "Run_"
        static let jumpPrefixKey = "Jump_"
        static let coinAtlas = "Coin Sprites"
        static let coinPrefixKey = "gold"
        
        //controls stuff
        static let jumpUpActionKey = "JumpUp"
        static let brakeDescendActionKey = "BrakeDescend"
        
        //particles
        static let coinDustEmitterKey = "CoinDustEmitter"
        static let jumpBoostEmitterKey = "JumpBoostEmitter"
        
        //audio
        static let backgroundMusicName = "backgroundMusic"
        static let buttonClickAudio = "buttonClick"
        static let coinCollectedAudio = "coinCollected"
        static let collectibleFoundAudio = "collectibleFoundB"
        static let gameLoseAudio = "gameLose"
        static let gameWinAudio = "gameWin"
        static let playerJumpAudio = "jump"
        
    }
    
    struct LayerSpeeds{
        static let worldSpeed: CGFloat = -150
        static let backgroundSpeed: CGFloat = -70
        static let foregroundSpeed: CGFloat = -250
    }
    
    struct PhysicsCategories{
        
        //basically custom masks to detect collisions on
        //i found this process pretty weird and difficult to understand at first
        static let noCategory: UInt32 = 0
        static let allCategory: UInt32 = UInt32.max
        static let playerCategory: UInt32 = 0x1
        static let groundCategory: UInt32 = 0x1 << 1
        static let finishCategory: UInt32 = 0x1 << 2
        static let collectibleCategory: UInt32 = 0x1 << 3
        static let enemyCategory: UInt32 = 0x1 << 4
        static let frameCategory: UInt32 = 0x1 << 5
        static let ceilingCategory: UInt32 = 0x1 << 6
    }
    
}
