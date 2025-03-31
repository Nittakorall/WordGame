//
//  EndGameViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-25.
//

import UIKit

class EndGameViewController: UIViewController {
    
    let highScoreManager = HighScoreManager()
    var finalScore : Int?
    var finalTime : Int?
    
    @IBAction func btnPlayAgain(_ sender: UIButton) {
    }
    @IBAction func btnBackToMain(_ sender: UIButton) {
    }
  
    @IBOutlet weak var labelFinalScore: UILabel!
    @IBOutlet weak var labelFinalTime: UILabel!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var btnPlayAgainOutlet: UIButton!
    @IBOutlet weak var btnStartPageOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSetup()
        updateHighScore()
    }
    
    func updateHighScore() {
        let timeString = formatTime(seconds: finalTime ?? 0)
        labelFinalScore.text = "Your score: \(finalScore ?? 0) points."
        labelFinalTime.text = "Your time: \(timeString)"
        highScoreManager.addHighScore(score: finalScore ?? 0, time: finalTime ?? 0)
    }
    
    func formatTime(seconds : Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func designSetup() {
        imageViewBackground.backgroundColor = .clear
        imageViewBackground.layer.borderWidth = 4
        imageViewBackground.layer.borderColor = UIColor.black.cgColor
        imageViewBackground.layer.cornerRadius = 20
        imageViewBackground.layer.masksToBounds = true
        
        btnPlayAgainOutlet.layer.borderWidth = 1
        btnPlayAgainOutlet.layer.borderColor = UIColor.gray.cgColor
        btnPlayAgainOutlet.layer.cornerRadius = 7
        btnPlayAgainOutlet.layer.masksToBounds = true
        
        btnPlayAgainOutlet.layer.shadowColor = UIColor.black.cgColor
        btnPlayAgainOutlet.layer.shadowOpacity = 1
        btnPlayAgainOutlet.layer.shadowOffset = CGSize(width: 0, height: 5)
        btnPlayAgainOutlet.layer.shadowRadius = 5
        btnPlayAgainOutlet.clipsToBounds = false
        
        btnStartPageOutlet.layer.borderWidth = 1
        btnStartPageOutlet.layer.borderColor = UIColor.gray.cgColor
        btnStartPageOutlet.layer.cornerRadius = 7
        btnStartPageOutlet.layer.masksToBounds = true
        
        btnStartPageOutlet.layer.shadowColor = UIColor.black.cgColor
        btnStartPageOutlet.layer.shadowOpacity = 1
        btnStartPageOutlet.layer.shadowOffset = CGSize(width: 0, height: 5)
        btnStartPageOutlet.layer.shadowRadius = 5
        btnStartPageOutlet.clipsToBounds = false
    }

}
