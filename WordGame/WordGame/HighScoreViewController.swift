//
//  HighScoreViewController.swift
//  WordGame
//
//  Created by Saeid Ahmadi on 2025-03-26.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test: Spara en high score
            saveHighScore(playerName: "Alex", score: 100)

            // Test: Hämta och skriva ut high scores
            let highScores = loadHighScores()
            for score in highScores {
                print("\(score.playerName): \(score.score)")
            }

    }
    

    func saveHighScore(playerName: String, score: Int) {
        let newScore = HighScore(playerName: playerName, score: score)

        var highScores = loadHighScores()
        highScores.append(newScore)

        // Sortera och behåll endast de 5 bästa poängen
        highScores.sort { $0.score > $1.score }
        highScores = Array(highScores.prefix(5))

        // Spara i UserDefaults
        if let encodedData = try? JSONEncoder().encode(highScores) {
            UserDefaults.standard.set(encodedData, forKey: "highScores")
        }
    }
    
    
    func loadHighScores() -> [HighScore] {
        if let savedData = UserDefaults.standard.data(forKey: "highScores"),
           let highScores = try? JSONDecoder().decode([HighScore].self, from: savedData) {
            return highScores
        }
        return []
    }
}
