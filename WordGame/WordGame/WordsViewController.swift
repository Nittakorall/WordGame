//
//  WordsViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-26.
//

import UIKit

class WordsViewController: UIViewController, UITableViewDataSource {
    
    //List to add custom pairs to
    var newList: [WordPair] = []
    
    
    
    @IBAction func addWordButton(_ sender: Any) {
        //Checks that the fields aren't empty
        guard let swedish = swedishInput.text, !swedish.isEmpty,
              let english = englishInput.text, !english.isEmpty else {
            return
        }
        
        
        let newWordPair = WordPair(english: english, swedish: swedish)
        
        
        newList.append(newWordPair)
        
        englishInput.text = ""
        swedishInput.text = ""
        
        
        tableViewWordLists.reloadData()
    }
    @IBOutlet weak var tableViewWordLists: UITableView!
    @IBOutlet weak var swedishInput: UITextField!
    @IBOutlet weak var englishInput: UITextField!
    
    @IBAction func startCustomGameButton(_ sender: Any) {
        performSegue(withIdentifier: "showGameScreen", sender: self)}
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewWordLists.dataSource = self
        tableViewWordLists.backgroundColor = .clear
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = newList[indexPath.row]
        
        cell.textLabel?.text = "\(item.english) - \(item.swedish)"
        cell.backgroundColor = .clear
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Papyrus", size: 20)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameScreen" {
            if let gameViewController = segue.destination as? GameViewController {
                //sends custom list to gameVC
                gameViewController.wordPairs = newList
            }
        }
    }
    
    //doesn't let to start a game if the newList is empty
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showGameScreen" {
            if newList.isEmpty {
                print("EMPTY")
                let alert = UIAlertController(title: "Error", message: "Your list is empty!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                
                return false
            }
        }
        return true
    }
}

