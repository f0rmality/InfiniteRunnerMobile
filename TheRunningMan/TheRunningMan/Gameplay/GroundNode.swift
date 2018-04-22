//
//  GroundNode.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-22.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    var bIsBodyActivated: Bool = false{
        didSet{
            physicsBody = bIsBodyActivated ? activatedBody : nil
        }
    }
    
    private var activatedBody: SKPhysicsBody?
    
    init(with size: CGSize){
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        //draw physics edge on top of the ground
        let bodyInitialPoint = CGPoint(x: 0.0, y: size.height)
        let bodyEndPoint = CGPoint(x: size.width, y: size.height)
        
        activatedBody = SKPhysicsBody(edgeFrom: bodyInitialPoint, to: bodyEndPoint)
        activatedBody?.restitution = 0.0
        
        physicsBody = bIsBodyActivated ? activatedBody : nil
        name = GameConstants.StringConstants.groundNodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
