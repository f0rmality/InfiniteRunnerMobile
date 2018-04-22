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
        static let groundTilesName = "GroundTiles"
        static let worldBackgroundNames = ["citybackground1", "scarybackground1"]
        static let playerName = "Player"
        static let playerImageName = "Idle_0"
        static let groundNodeName = "GroundNode"
    }
    
    struct LayerSpeeds{
        static let worldSpeed: CGFloat = -100
        static let backgroundSpeed: CGFloat = -50
    }
    
}
