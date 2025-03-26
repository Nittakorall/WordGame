//
//  WordsViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-26.
//

import UIKit

class WordsViewController: UIViewController, UITableViewDataSource {
    
    // Массив для хранения пар слов
    var newList: [WordPair] = []
    
    // UI компоненты
    @IBOutlet weak var tebleViewWordLists: UITableView!
    @IBOutlet weak var englishInput: UITextField!
    
    @IBOutlet weak var swedishInput: UITextField!
    
   
    @IBAction func buttonStartCustomGame(_ sender: Any) {
        performSegue(withIdentifier: "showGameScreen1", sender: self)
    }
    

    
    @IBAction func buttonAddWord(_ sender: Any) {
    
        guard let swedish = swedishInput.text, !swedish.isEmpty,
              let english = englishInput.text, !english.isEmpty else {
            return
        }
        
        // Создаем новую пару слов
        let newWordPair = WordPair(english: english, swedish: swedish)
        
        // Добавляем пару в список
        newList.append(newWordPair)
        
        // Очистка текстовых полей
        englishInput.text = ""
        swedishInput.text = ""
        
        // Обновляем таблицу
        tebleViewWordLists.reloadData()
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка dataSource для таблицы
        tebleViewWordLists.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    // Количество строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newList.count
    }
    
    // Заполнение ячеек таблицы данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Получаем пару слов
        let item = newList[indexPath.row]
        
        // Отображаем пару в ячейке
        cell.textLabel?.text = "\(item.english) - \(item.swedish)"
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameScreen1" {
            if let gameViewController = segue.destination as? GameViewController {
                
                gameViewController.wordPairs = newList
            }
        }
    }
}
