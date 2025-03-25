//
//  GameViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-25.
//

import UIKit

class GameViewController: UIViewController {
    
    var wordPairs: [WordPair] = [
        WordPair(english: "cat", swedish: "katt"),
        WordPair(english: "dog", swedish: "hund"),
        WordPair(english: "bird", swedish: "fågel")
    ]
    
    var usedIndexes: [Int] = []
    var score = 0
    
    @IBOutlet weak var labelWordTimer: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var labelWord: UILabel!
    @IBOutlet weak var textFieldTranslation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showRandomSwedishWord()
        updateScore()
    }
    
    func showRandomSwedishWord() {
        
        if usedIndexes.count == wordPairs.count {
           
           // usedIndexes.removeAll() if we want it to loop
        }
        
        
        var randomIndex: Int
        repeat {
            randomIndex = Int.random(in: 0..<wordPairs.count)
        } while usedIndexes.contains(randomIndex)
        usedIndexes.append(randomIndex)
        
        
        let selectedWordPair = wordPairs[randomIndex]
        labelWord.text = selectedWordPair.swedish
    }
    
    @IBAction func btnCheckAnswer(_ sender: UIButton) {
        
        if let userTranslation = textFieldTranslation.text, !userTranslation.isEmpty {
            let currentWord = wordPairs[usedIndexes.last!]
                if userTranslation.lowercased() == currentWord.english.lowercased() {
                            
                               score = score + 1
                               print("Correct! Current score: \(score)")
                           } else {
                               score = score - 1
                               print("Incorrect.")
                           }
                       
        }
        updateScore()
        textFieldTranslation.text = ""
        showRandomSwedishWord()
    }
    func updateScore() {
           labelPoints.text = "Poäng: \(score)"
       }
   }

