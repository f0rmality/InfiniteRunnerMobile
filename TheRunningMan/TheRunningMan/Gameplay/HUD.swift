//
//  HUD.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit

class HUD: SKSpriteNode, HUDDelegate {
    
    var coinInfo: SKLabelNode
    var specialCollectibleCounter: SKSpriteNode
    
    init(with size: CGSize){
        coinInfo = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)
        specialCollectibleCounter = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 0.3, height: size.height * 0.8))
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        //the coin info node
        coinInfo.verticalAlignmentMode = .center
        coinInfo.text = "0"
        coinInfo.fontSize = 200.0
        coinInfo.scale(to: frame.size, width: false, multiplier: 0.8)
        coinInfo.position = CGPoint(x: frame.maxX - coinInfo.frame.size.width*2, y: frame.midY)
        coinInfo.zPosition = GameConstants.ZPositions.HUDZ
        addChild(coinInfo)
        
        specialCollectibleCounter.position = CGPoint(x: frame.minX + specialCollectibleCounter.frame.size.width/2, y: frame.midY)
        specialCollectibleCounter.zPosition = GameConstants.ZPositions.HUDZ
        addChild(specialCollectibleCounter)
        
        //initialize the empty slots for the collectibles, they will become more visible when collected
        for i in 0..<3{
            let emptySlot = SKSpriteNode(imageNamed: GameConstants.StringConstants.specialCollectibleImageName)
            emptySlot.name = String(i)
            emptySlot.alpha = 0.5
            emptySlot.scale(to: specialCollectibleCounter.size, width: true, multiplier: 0.3)
            emptySlot.position = CGPoint(x: -specialCollectibleCounter.size.width / 2 + emptySlot.size.width/2 + CGFloat(i)*specialCollectibleCounter.size.width/3 + specialCollectibleCounter.size.width*0.05, y: specialCollectibleCounter.frame.midY)
            emptySlot.zPosition = GameConstants.ZPositions.HUDZ
            specialCollectibleCounter.addChild(emptySlot)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCoinInfo(coins: Int) {
        coinInfo.text = "\(coins)"
    }
    
    func addSpecialCollectible(index: Int) {
        let emptySlot = specialCollectibleCounter[String(index)].first as! SKSpriteNode
        emptySlot.alpha = 1.0
    }
    
}
