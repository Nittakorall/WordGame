//
//  EndGameViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-25.
//

import UIKit

class EndGameViewController: UIViewController {
    
    var finalScore : Int?
    var finalTime : Int?
    
    @IBAction func btnPlayAgain(_ sender: UIButton) {
    }
    @IBAction func btnBackToMain(_ sender: UIButton) {
    }
  
    @IBOutlet weak var labelFinalScore: UILabel!
    @IBOutlet weak var labelFinalTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timeString = formatTime(seconds: finalTime ?? 0)
        
        labelFinalScore.text = "Your score: \(finalScore ?? 0) points."
        labelFinalTime.text = "Your time: \(timeString)"
        
        // Spara high score när skärmen visas
        saveHighScore(newScore: finalScore ?? 0)

    }
    
    func formatTime(seconds : Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func saveHighScore(newScore: Int) {
        var scores = UserDefaults.standard.array(forKey: "HighScores") as? [Int] ?? []
        scores.append(newScore)
        scores = scores.sorted(by: >).prefix(5).map { $0 } // Spara bara top 5
        UserDefaults.standard.set(scores, forKey: "HighScores")
    }

    
    @IBAction func showHighScores(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let highScoreVC = storyboard.instantiateViewController(withIdentifier: "HighScoreViewController") as? HighScoreViewController {
            self.present(highScoreVC, animated: true, completion: nil)
        }
    }
 

}
