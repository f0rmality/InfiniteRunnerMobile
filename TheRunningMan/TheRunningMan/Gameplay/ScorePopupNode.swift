//
//  ScorePopupNode.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit

class ScorePopupNode: PopupNode {
    
    var level: String
    var score: [String:Int]
    var scoreLabel: SKLabelNode!
    
    init(buttonHandlerDelegate: PopupButtonHandlerDelegate, title: String, level: String, texture: SKTexture, score: Int, collectibles: Int, animated: Bool){
        
        self.level = level
        self.score = ScoreManager.getCurrentScore(for: level)
        
        super.init(withTitle: title, and: texture, buttonHandlerDelegate: buttonHandlerDelegate)
        
        addScoreLabel()
        addStars()
        addCollectibles(count: collectibles)
        
        if(animated){
            animateResult(with: CGFloat(score), and: 100.0)
            
        }
        
        //show the info
        else{
            scoreLabel.text = "\(score)"
            for i in 0..<self.score[GameConstants.StringConstants.scoreStarsKey]!{
                self[GameConstants.StringConstants.fullStar + "_\(i)"].first!.alpha = 1.0
            }
        }
    }
    
    func addScoreLabel(){
        scoreLabel = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)
        scoreLabel.fontSize = 200.0
        scoreLabel.text = "0"
        scoreLabel.scale(to: size, width: false, multiplier: 0.1)
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - size.height * 0.6)
        scoreLabel.zPosition = GameConstants.ZPositions.HUDZ
        addChild(scoreLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //marked out of 3 stars
    func addStars(){
        for i in 0...2{
            
            //adding both sprites right away, hide the filled stars until the player earns them
            let empty = SKSpriteNode(imageNamed: GameConstants.StringConstants.emptyStar)
            let star = SKSpriteNode(imageNamed: GameConstants.StringConstants.fullStar)
            
            //figuring out the best way to make these stars look good is really annoying
            empty.scale(to: size, width: true, multiplier: 0.25)
            empty.position = CGPoint(x: -empty.size.width + CGFloat(i) * empty.size.width, y: frame.maxY - size.height * 0.4)

            //push the center star up a bit to make it look nicer
            if(i==1){
                empty.position.y += empty.size.height/4
            }
            
            empty.zPosition = GameConstants.ZPositions.HUDZ
            
            //set the stars equivalent to the empty ones since theyll be taking their spots
            star.size = empty.size
            star.position = empty.position
            star.zPosition = empty.zPosition
            star.name = GameConstants.StringConstants.fullStar + "_\(i)"
            star.alpha = 0.0
            
            addChild(empty)
            addChild(star)
        }
    }
    
    func addCollectibles(count: Int){
        //get current number of collectibles held
        let numberOfCollectibles = count == 4 ? score[GameConstants.StringConstants.scoreCollectiblesKey]! : count
        
        //add symbol for collectibles
        let collectible = SKSpriteNode(imageNamed: GameConstants.StringConstants.specialCollectibleImageName)
        collectible.scale(to: size, width: false, multiplier: 0.15)
        collectible.position = CGPoint(x: -collectible.size.width/1.5, y: frame.maxY - size.height * 0.75)
        collectible.zPosition = GameConstants.ZPositions.HUDZ
        addChild(collectible)
        
        //add label for collectibles, show current amount out of number in level
        let collectibleLabel = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)
        collectibleLabel.verticalAlignmentMode = .center
        collectibleLabel.fontSize = 200.0
        collectibleLabel.text = "\(numberOfCollectibles)/3"
        collectibleLabel.scale(to: collectible.size, width: false, multiplier: 1.0)
        collectibleLabel.position = CGPoint(x: collectible.size.width/1.5, y: frame.maxY - size.height * 0.75)
        collectibleLabel.zPosition = GameConstants.ZPositions.HUDZ
        addChild(collectibleLabel)
    }
    
    func animateResult(with achievedScore: CGFloat, and maxScore: CGFloat){
        //TO DO: counter effect for the end score
    }
    
    //SKActions to make a nice effect for the stars filling in
    func animateStar(number: Int){
        let star = self[GameConstants.StringConstants.fullStar + "_\(number)"].first!
        let fadeIn = SKAction.fadeIn(withDuration: 0.1)
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.1)
        
        star.run(SKAction.group([fadeIn, scaleUp, scaleDown]))
    }
}
