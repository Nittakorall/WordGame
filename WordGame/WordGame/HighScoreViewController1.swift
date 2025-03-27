//
//  HighScoreViewController1.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-27.
//

import Foundation
import UIKit

class HighScoreViewController1: UIViewController {



    
    @IBOutlet weak var highScoretableView: UITableView!
    
    

    
    // Массив для хранения высоких баллов
    var highScores: [HighScore] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Загрузка high scores из UserDefaults
           highScores = loadHighScores()

           // Для теста: сохранение нового high score (например, игрока Alex с баллом 100)
           saveHighScore(playerName: "Alex", score: 100)
           
           // Для теста: вывести high scores в таблицу
           print("Current High Scores:")
           for score in highScores {
               print("\(score.playerName): \(score.score)")
           }
           
           // Обновить таблицу с новыми данными
           highScoretableView.reloadData()
       }

       // MARK: - UITableViewDataSource

       // Количество строк в таблице (количество элементов в highScores)
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return highScores.count
       }

       // Заполнение ячеек таблицы данными из highScores
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           // Получаем high score по индексу
           let highScore = highScores[indexPath.row]
           
           // Отображаем имя игрока и его балл в ячейке
           cell.textLabel?.text = "\(highScore.playerName): \(highScore.score)"
           
           return cell
       }

       // MARK: - Сохранение и загрузка высоких баллов
       
       // Сохранение нового high score
       func saveHighScore(playerName: String, score: Int) {
           let newScore = HighScore(playerName: playerName, score: score)

           // Загружаем текущие high scores
           var highScores = loadHighScores()
           
           // Добавляем новый high score
           highScores.append(newScore)

           // Сортируем high scores и сохраняем только 5 лучших
          //             highScores.sort { $0.score > $1.score }
           // highScores = Array(highScores.prefix(5))

           // Сохраняем обновленный список в UserDefaults
           if let encodedData = try? JSONEncoder().encode(highScores) {
               UserDefaults.standard.set(encodedData, forKey: "highScores")
           }
           
           // Обновляем локальный массив
           self.highScores = highScores
       }
       
       // Загрузка сохраненных high scores из UserDefaults
       func loadHighScores() -> [HighScore] {
           if let savedData = UserDefaults.standard.data(forKey: "highScores"),
              let highScores = try? JSONDecoder().decode([HighScore].self, from: savedData) {
               return highScores
           }
           return []
       }
   }
