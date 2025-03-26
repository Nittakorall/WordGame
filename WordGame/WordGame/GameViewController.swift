//
//  GameViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-25.
//

import UIKit

class GameViewController: UIViewController {
    
//    var wordPairs: [WordPair] = [
//        WordPair(english: "cat", swedish: "katt"),
//        WordPair(english: "dog", swedish: "hund"),
//        WordPair(english: "bird", swedish: "fågel"),
//        WordPair(english: "worm", swedish: "mask"),
//        WordPair(english: "shark", swedish: "haj"),
//        WordPair(english: "goat", swedish: "get")
//    ]
    var wordPairs: [WordPair] = []
    
    var usedIndexes: [Int] = []
    var score = 0
    
    // When remainingTime reaches 0, a notification is posted to NotificationCenter to notify observer that this has happened.
    var remainingTime: Int = 5{
        didSet {
            if remainingTime == 0 {
                NotificationCenter.default.post(name: .timerDidReachZero, object: nil)
            }
        }
    }
    var wordTimer : Timer?
    var gameTimer : Timer?
    var totalTime: Int = 0
    // viewDidLoad kept running every second which triggered the performSegue every time. Therefore I created this variable to stop it.
    var isEndGamePresented = false
    
    @IBOutlet weak var labelWordTimer: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var labelWord: UILabel!
    @IBOutlet weak var textFieldTranslation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registers an observer for the notification "timerDidReachZero", which is posted when remainingTime is 0. When notification is posted, this calls upon the function timerDidReachZero.
        NotificationCenter.default.addObserver(self, selector: #selector(timerDidReachZero), name: .timerDidReachZero, object: nil)
        
        showRandomSwedishWord()
        updateScore()
        startWordTimer()
        startGameTimer()
    }
    
    func showRandomSwedishWord() {
        if usedIndexes.count == wordPairs.count && !isEndGamePresented {
//            usedIndexes.removeAll() //if we want it to loop
            isEndGamePresented = true
            performSegue(withIdentifier: "showEndGameViewController", sender: self)
            // Had to put this in an else-block for the segue to be performed, otherwise the loop kept going and stopped the performSegue.
        } else {
            var randomIndex: Int
            repeat {
                randomIndex = Int.random(in: 0..<wordPairs.count)
            } while usedIndexes.contains(randomIndex)
            usedIndexes.append(randomIndex)
            
            let selectedWordPair = wordPairs[randomIndex]
            labelWord.text = selectedWordPair.swedish
        }
    }
    
    @IBAction func btnCheckAnswer(_ sender: UIButton) {
        wordTimer?.invalidate()
        checkTranslation()
        updateScore()
        textFieldTranslation.text = ""
        showRandomSwedishWord()
        remainingTime = 5
        startWordTimer()
    }
    
    func updateScore() {
        labelPoints.text = "Poäng: \(score)"
    }
    
    func checkTranslation() {
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
    }
    
    // Format time for clock in minutes and seconds (2-digits)
    func formatTime(seconds : Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Set time in UI.
    func updateWordTimer(label : UILabel, remainingTime : Int) {
        let formattedTime = formatTime(seconds:remainingTime)
        label.text = formattedTime
    }
    
    // Start timer for words.
    func startWordTimer() {
        wordTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.remainingTime -= 1
            self.updateWordTimer(label: self.labelWordTimer, remainingTime: self.remainingTime)
        }
    }
    
    // Start timer for total playtime.
    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.totalTime += 1
        }
    }
    
    // Called upon when notification is posted that remainingTime is 0. The observer is notified and calls upon this function.
    @objc func timerDidReachZero() {
        wordTimer?.invalidate()
        score += -1
        updateScore()
        textFieldTranslation.text = ""
        showRandomSwedishWord()
        remainingTime = 5
        startWordTimer()
    }
    
    // Removes connection to NotificationCenter when View Controller is deinitialised to prevent memory leaks.
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Inactive timers and set to nil when view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        wordTimer?.invalidate()
        wordTimer = nil
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    // Sending score and total game time to EndGameViewController when performSegue runs.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEndGameViewController" {
           if let destinationVC = segue.destination as? EndGameViewController {
               destinationVC.finalScore = score
               destinationVC.finalTime = totalTime
           }
       }
    }
    
}

// Defines a notification name (timerDidReachZero) to observe when remainingTime reaches 0 = wordTimer reaches 0. Used to trigger functionality defined in timerDidReachZero function.
extension Notification.Name {
    static let timerDidReachZero = Notification.Name("timerDidReachZero")
}

