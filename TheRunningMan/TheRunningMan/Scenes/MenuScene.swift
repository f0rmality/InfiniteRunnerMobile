//
//  MenuScene.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit
import UIKit

class MenuScene: SKScene {
    
    var sceneManagerDelegate: SceneManagerDelegate?

    override func didMove(to view: SKView) {
        layoutView()
    }
    
    func layoutView(){
        //background image
        let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[0])
        //backgroundImage.size = size
        backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundImage.zPosition = GameConstants.ZPositions.farBGZ
        addChild(backgroundImage)
        
        //setup game title
        let logoLabel = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)
        logoLabel.text = GameConstants.StringConstants.gameName
        logoLabel.fontSize = 200.0
        logoLabel.fontColor = UIColor.black
        logoLabel.scale(to: frame.size, width: true, multiplier: 0.8)
        logoLabel.position = CGPoint(x: frame.midX, y: frame.maxY * 0.75 - logoLabel.frame.size.height/2)
        logoLabel.zPosition = GameConstants.ZPositions.HUDZ
        addChild(logoLabel)
        
        let startButton = SpriteKitButton(defaultButtonImage: GameConstants.StringConstants.playButton, action: goToLevelScene, index: 0)
        startButton.scale(to: frame.size, width: false, multiplier: 0.1)
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.zPosition = GameConstants.ZPositions.HUDZ
        addChild(startButton)
        
    }
    
    func goToLevelScene(_: Int){
        sceneManagerDelegate?.presentGameScene(for: 1, in: 1)
    }
    
}
