//
//  BannerLabel.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit

class BannerLabel: SKSpriteNode {
    
    init(withTitle title: String){
        let texture = SKTexture(imageNamed: GameConstants.StringConstants.banner)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        //add the text to the image
        let label = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)
        label.fontSize = 200.0
        label.verticalAlignmentMode = .center
        label.text = title
        label.scale(to: size, width: false, multiplier: 0.3)
        label.zPosition = GameConstants.ZPositions.HUDZ
        label.fontColor = UIColor.black
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
