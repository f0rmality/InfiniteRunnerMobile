//
//  PopupNode.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit

class PopupNode: SKSpriteNode {
    
    var buttonHandlerDelegate: PopupButtonHandlerDelegate
    
    init(withTitle title: String, and texture: SKTexture, buttonHandlerDelegate: PopupButtonHandlerDelegate){
        self.buttonHandlerDelegate = buttonHandlerDelegate
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        //add title to popup, centered on top
        let label = BannerLabel(withTitle: title)
        label.scale(to: size, width: true, multiplier: 1.1)
        label.zPosition = GameConstants.ZPositions.HUDZ
        label.position = CGPoint(x: frame.midX, y: frame.maxY)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButton(buttons: [Int]){
        
        let scalar = 1.0/CGFloat(buttons.count - 1)
        
        for(index, button) in buttons.enumerated(){
            let buttonToAdd = SpriteKitButton(defaultButtonImage: GameConstants.StringConstants.popupButtonNames[index], action: buttonHandlerDelegate.popupButtonHandler, index: button)
            
            //positioning buttons properly
            buttonToAdd.position = CGPoint(x: -frame.maxX/2 + CGFloat(index) * scalar * (frame.size.width*0.5), y: frame.minY)
            buttonToAdd.zPosition = GameConstants.ZPositions.HUDZ
            buttonToAdd.scale(to: frame.size, width: true, multiplier: 0.25)
            addChild(buttonToAdd)
            
        }
    }
    
}
