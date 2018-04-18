//
//  SKNodeExtensions.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-17.
//

import SpriteKit

extension SKNode{
    
    //load scene from a name
    class func unarchiveFromFile(file: String) -> SKNode?{
        if let path = Bundle.main.path(forResource: file, ofType: "sks"){
            let url = URL(fileURLWithPath: path)
            
            do {
                let sceneData = try Data(contentsOf: url, options: .mappedIfSafe)
                let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
                archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKNode
                archiver.finishDecoding()
                
                return scene
            }
            
            catch{
                print(error.localizedDescription)
                return nil
            }
        }
        
        else{
            return nil
        }
    }
    
    //scaling for all resolutions, makes adapting for different displays easy
    //bool is for scaling using either screen width or height
    func scale(to screenSize: CGSize, width: Bool, multiplier: CGFloat){
        let scale = width ? (screenSize.width * multiplier) / self.frame.size.width : (screenSize.height * multiplier) / self.frame.size.height
        
        self.setScale(scale)
    }
    
    //quick switching for gravity
    func turnGravity(on value: Bool){
        physicsBody?.affectedByGravity = value
    }
    
    //quick saving user data
    func createUserData(entry: Any, forKey key: String){
        if userData == nil {
            let userDataDictionary = NSMutableDictionary()
            userData = userDataDictionary
        }
        
        userData!.setValue(entry, forKey: key)
    }
}
