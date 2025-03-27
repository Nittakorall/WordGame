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
    
    @IBOutlet weak var labelFinalScore: UILabel!
    @IBOutlet weak var labelFinalTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timeString = formatTime(seconds: finalTime ?? 0)
        
        labelFinalScore.text = "Your score: \(finalScore ?? 0) points."
        labelFinalTime.text = "Your time: \(timeString)"

        // Do any additional setup after loading the view.
    }
    
    func formatTime(seconds : Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
 

}
