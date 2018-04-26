//
//  ScoreManager.swift
//  TheRunningMan
//
//  Created by Matthew Mazza on 2018-04-25.
//

import Foundation

//saving scores using dictionaries
struct ScoreManager{
    
    static func getCurrentScore(for levelKey: String) -> [String:Int]{
        
        //if we already have score info, return it
        if let existingData = UserDefaults.standard.dictionary(forKey: levelKey) as? [String:Int]{
            return existingData
        }
        
        //else return a new empty score
        else{
            return [GameConstants.StringConstants.scoreScoreKey: 0, GameConstants.StringConstants.scoreStarsKey: 0, GameConstants.StringConstants.scoreCollectiblesKey: 0]
        }
        
    }
    
    static func updateScore(for levelKey: String, and score: [String:Int]){
        //save new score of the specified level (the key)
        UserDefaults.standard.set(score, forKey: levelKey)
        UserDefaults.standard.synchronize()
    }
    
    static func compare(scores: [[String:Int]], in levelKey: String){
        
        //get all parts of the score (stars, 'score' = coins collected in level, and collectibles)
        var newHighScore = false
        let currentScore = getCurrentScore(for: levelKey)
        var maxScore = currentScore[GameConstants.StringConstants.scoreScoreKey]!
        var maxStars = currentScore[GameConstants.StringConstants.scoreStarsKey]!
        var maxCollectibles = currentScore[GameConstants.StringConstants.scoreCollectiblesKey]!
        
        //compare the different scores and see if any of them beat the current highest score
        for score in scores{
            if score[GameConstants.StringConstants.scoreScoreKey]! > maxScore{
                maxScore = score[GameConstants.StringConstants.scoreScoreKey]!
                newHighScore = true
            }
            
            if score[GameConstants.StringConstants.scoreStarsKey]! > maxStars{
                maxStars = score[GameConstants.StringConstants.scoreStarsKey]!
                newHighScore = true
            }
            
            if score[GameConstants.StringConstants.scoreCollectiblesKey]! > maxCollectibles{
                maxCollectibles = score[GameConstants.StringConstants.scoreCollectiblesKey]!
                newHighScore = true
            }
            
            //if so, replace the old high score with the new one
            if newHighScore{
                let newScore = [GameConstants.StringConstants.scoreScoreKey: maxScore, GameConstants.StringConstants.scoreStarsKey: maxStars, GameConstants.StringConstants.scoreCollectiblesKey: maxCollectibles]
                
                updateScore(for: levelKey, and: newScore)
            }
        }
    }
    
}
