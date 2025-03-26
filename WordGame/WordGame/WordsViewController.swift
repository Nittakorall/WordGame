//
//  WordsViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-26.
//

import UIKit

class WordsViewController: UIViewController, UITableViewDataSource {
    
    
    var newList: [WordPair] = []
    
   
   
    @IBAction func addWordButton(_ sender: Any) {
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
        performSegue(withIdentifier: "showGameScreen", sender: self)
    }
 
    

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        tableViewWordLists.dataSource = self
    }
    
   
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newList.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let item = newList[indexPath.row]
        
        
        cell.textLabel?.text = "\(item.english) - \(item.swedish)"
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameScreen" {
            if let gameViewController = segue.destination as? GameViewController {
                
                gameViewController.wordPairs = newList
            }
        }
    }
}

