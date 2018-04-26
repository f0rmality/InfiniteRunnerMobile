//
//  ParticleHelper.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-24.
//

import SpriteKit

class ParticleHelper{
    
    static func addParticleEffect(name: String, particlePositionRange: CGVector, position: CGPoint) -> SKEmitterNode?{
        if let emitter = SKEmitterNode(fileNamed: name){
            emitter.particlePositionRange = particlePositionRange
            emitter.position = position
            emitter.name = name
            
            return emitter
        }
        
        return nil
    }
    
    static func removeParticleEffect(name: String, from node: SKNode){
        let emitters = node[name]
        
        for emitter in emitters{
            emitter.removeFromParent()
        }
    }
}
