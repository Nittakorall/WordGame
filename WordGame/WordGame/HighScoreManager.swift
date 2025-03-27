//
//  HighScoreManager.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-27.
//

import Foundation

class HighScoreManager {
    
    private let highScoreKey = "HighScore"
    
    func saveHighScores(_ scores: [(score: Int, time: Int)]) {
        let scoreDictionaries = scores.map { ["score": $0.score, "time": $0.time] }
        UserDefaults.standard.set(scoreDictionaries, forKey: highScoreKey)
    }
    
    func addHighScore(score: Int, time: Int) {
        var scores = getHighScores()
        scores.append((score: score, time: time))
        
        scores.sort {
            // If two scores are the same, sort them by time with the lowest time furthest up.
            if $0.score == $1.score {
                return $0.time < $1.time
            }
            return $0.score > $1.score // If the scores are not the same, sort on highest score furthest up.
        }
        // Only 5 high scores.
        if scores.count > 5 {
            scores.removeLast(scores.count - 5) // Remove values that don't make the list from the sorting above.
        }
        
        saveHighScores(scores)
    }
    
    func getHighScores() -> [(score: Int, time: Int)] {
        guard let scoreDictionaries = UserDefaults.standard.array(forKey: highScoreKey) as? [[String: Any]] else {
            return []
        }
        
        return scoreDictionaries.compactMap { dict in
            if let score = dict["score"] as? Int, let time = dict["time"] as? Int {
                return (score: score, time: time)
            }
            return nil
        }
    }
    
}
