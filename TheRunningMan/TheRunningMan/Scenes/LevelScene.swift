//
//  LevelScene.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import SpriteKit

class LevelScene: SKScene {
    var world: Int!
    var level: Int!
    
    var popupLayer: SKNode!
    var sceneManagerDelegate: SceneManagerDelegate?
    
    override func didMove(to view: SKView) {
        layoutScene(for: world)
    }
    
    func layoutScene(for world: Int){
        
    }
}
