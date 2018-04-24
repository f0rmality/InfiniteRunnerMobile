//
//  AnimationHelper.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-24.
//

import SpriteKit

class AnimationHelper{
    
    //takes in atlas and name, will return an array of all the textures for the animation loop
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture]{
        var textures = [SKTexture]()
        
        for index in 0..<atlas.textureNames.count{
            
            //image names are stored as "Name_X" so index will be X
            let textureName = name + String(index)
            textures.append(atlas.textureNamed(textureName))
        }
        
        return textures
    }
    
}
