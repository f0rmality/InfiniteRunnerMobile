//
//  GameViewController.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-17.
//

import UIKit
import SpriteKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        presentMenuScene()
        //presentGameScene(for: 0, in: 0)
        startBackgroundMusic()
    }
    
    func startBackgroundMusic(){
        let path = Bundle.main.path(forResource: GameConstants.StringConstants.backgroundMusicName, ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.volume = 0.25
        backgroundMusicPlayer.play()
    }
}

extension GameViewController: SceneManagerDelegate{
    func presentMenuScene() {
        let scene = MenuScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegate = self
        present(scene: scene)
    }
    
    func presentLevelScene(for world: Int) {

    }
    
    func presentGameScene(for level: Int, in world: Int) {
        //hardcoding this for now
        let scene = GameScene(size: view.bounds.size, world: world, level: level, sceneManagerDelegate: self)
        scene.scaleMode = .aspectFill
        
        present(scene: scene)
    }
    
    func present(scene: SKScene){
        if let view = self.view as! SKView? {
            
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
}
