//
//  SceneManagerDelegate.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import Foundation

protocol SceneManagerDelegate{
    func presentLevelScene(for world: Int)
    func presentGameScene(for level: Int, in world: Int)
    func presentMenuScene()
}
