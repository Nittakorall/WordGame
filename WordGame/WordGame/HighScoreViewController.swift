//
//  HighScoreViewController.swift
//  WordGame
//
//  Created by Saeid Ahmadi on 2025-03-26.
//

import UIKit

class HighScoreViewController: UIViewController {

   
 
    @IBOutlet weak var tableView: UITableView!
    
    //list to save high scores
    var highScores: [HighScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScores = loadHighScores()

        // Test: Spara en high score
            saveHighScore(playerName: "Alex", score: 100)

            // Test: Hämta och skriva ut high scores
         //   let highScores = loadHighScores()
            for score in highScores {
                print("\(score.playerName): \(score.score)")
            }
        //update info
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return highScores.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           // Получаем high score по индексу
           let highScore = highScores[indexPath.row]
           
           // Отображаем имя игрока и его балл
           cell.textLabel?.text = "\(highScore.playerName): \(highScore.score)"
           
           return cell
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
        self.highScores = highScores
        
    }
    
    
    func loadHighScores() -> [HighScore] {
        if let savedData = UserDefaults.standard.data(forKey: "highScores"),
           let highScores = try? JSONDecoder().decode([HighScore].self, from: savedData) {
            return highScores
        }
        return []
    }
}
