//
//  HighScoreViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-27.
//

import Foundation
import UIKit

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    let highScoreManager = HighScoreManager()
    var scores: [(score: Int, time: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scores = highScoreManager.getHighScores()
        highScoreTableView.backgroundColor = .clear
        highScoreTableView.reloadData()
    }
    
    func formatTime(seconds : Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension HighScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        let score = scores[indexPath.row]
        let formattedTime = formatTime(seconds: score.time)
        cell.textLabel?.text = "Score: \(score.score). Time: \(formattedTime)"
        cell.backgroundColor = .clear
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Papyrus", size: 25)
        
        return cell
    }
    
}

