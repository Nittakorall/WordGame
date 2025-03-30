//
//  GameViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-25.
//

import UIKit

class GameViewController: UIViewController {
    
    //list that gets lists from other VC with word pairs
    var wordPairs: [WordPair] = []
    
    //stores index of words from wordPair to avoit repeating same words during the game
    var usedIndexes: [Int] = []
    var score = 0
    
    var difficulty: Int = 0
    
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
    @IBOutlet weak var btnCheckAnswerOutlet: UIButton!
    @IBOutlet weak var labelCorrectTranslation: UILabel!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get's our default list of pairs from AppDelegate
        //        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        //           wordPairs = appDelegate.globalWordPairs
        //       }
        
        // Registers an observer for the notification "timerDidReachZero", which is posted when remainingTime is 0. When notification is posted, this calls upon the function timerDidReachZero.
        NotificationCenter.default.addObserver(self, selector: #selector(timerDidReachZero), name: .timerDidReachZero, object: nil)
        
        labelCorrectTranslation.alpha = 0
        designSetup()
        showRandomSwedishWord()
        updateScore()
        startWordTimer()
        startGameTimer()
    }
    
    func showRandomSwedishWord() {
        if usedIndexes.count == wordPairs.count && !isEndGamePresented {
            //            usedIndexes.removeAll() //if we want it to loop
            isEndGamePresented = true
            wordTimer?.invalidate()
            wordTimer = nil
            gameTimer?.invalidate()
            gameTimer = nil
            NotificationCenter.default.removeObserver(self)
            performSegue(withIdentifier: "showEndGameViewController", sender: self)
            // Had to put this in an else-block for the segue to be performed, otherwise the loop kept going and stopped the performSegue.
        } else {
            var randomIndex: Int
            
            for _ in 0..<wordPairs.count {
                randomIndex = Int.random(in: 0..<wordPairs.count)
                if !usedIndexes.contains(randomIndex) {
                    //move wordpair index to the used ones
                    usedIndexes.append(randomIndex)
                    // show word pair
                    let selectedWordPair = wordPairs[randomIndex]
                    labelWord.text = selectedWordPair.swedish
                    // end for loop when the unused index is found
                    break
                
                }
            }
            
        }
        
    }
    @IBAction func btnCheckAnswer(_ sender: UIButton) {
        wordTimer?.invalidate()
        checkTranslation()
        updateScore()
    }
    
    func updateScore() {
        labelPoints.text = "Poäng: \(score)"
    }
    
    func checkTranslation() {
        btnCheckAnswerOutlet.isEnabled = false
        
        if let userTranslation = textFieldTranslation.text {
            let currentWord = wordPairs[usedIndexes.last!]
            
            print("Translation: \(userTranslation)")
            print("Current word: \(currentWord.english)")
            labelCorrectTranslation.alpha = 1
            labelCorrectTranslation.text = currentWord.english
            if userTranslation.lowercased() == currentWord.english.lowercased() {
                score = score + 1
                print("Correct!")
                textFieldTranslation.backgroundColor = UIColor(red: 0.058, green: 0.741, blue: 0.568, alpha: 0.7)
            } else {
                score = score - 1
                print("Incorrect.")
                textFieldTranslation.backgroundColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 0.7)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.textFieldTranslation.backgroundColor = UIColor.white
            self.textFieldTranslation.text = ""
            self.showRandomSwedishWord()
            if self.difficulty == 1 {
                self.remainingTime = 16
            } else {
                self.remainingTime = 11
            }
            self.startWordTimer()
            self.btnCheckAnswerOutlet.isEnabled = true
            self.labelCorrectTranslation.alpha = 0
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
        textFieldTranslation.backgroundColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1.0)
        btnCheckAnswerOutlet.isEnabled = false
        labelCorrectTranslation.alpha = 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.textFieldTranslation.backgroundColor = UIColor.white
            self.textFieldTranslation.text = ""
            self.showRandomSwedishWord()
            if self.difficulty == 1 {
                self.remainingTime = 16
            } else {
                self.remainingTime = 11
            }
            self.startWordTimer()
            self.btnCheckAnswerOutlet.isEnabled = true
            self.labelCorrectTranslation.alpha = 0
        }
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
    
    func resetGame() {
        // Stops the timers
        wordTimer?.invalidate()
        gameTimer?.invalidate()
        
        // Resets the game's variables
        usedIndexes.removeAll()
        score = 0
        totalTime = 0
        if difficulty == 1 {
            remainingTime = 16
        } else {
            remainingTime = 11
        }
        isEndGamePresented = false
        
        // resets the UI
        updateScore()
        updateWordTimer(label: labelWordTimer, remainingTime: remainingTime)
        
        // restarts the timers and display the first words
        showRandomSwedishWord()
        startWordTimer()
        startGameTimer()
    }
    
    // takes the player back to the game screen when pressing 'Play Again'
    @IBAction func unwindToGameViewController(_ segue: UIStoryboardSegue) {
        resetGame()
    }
    
    func designSetup() {
        imageViewBackground.backgroundColor = .clear
        imageViewBackground.layer.borderWidth = 4
        imageViewBackground.layer.borderColor = UIColor.black.cgColor
        imageViewBackground.layer.cornerRadius = 20 // Ändra 10 till det värde du vill ha för rundningen
        imageViewBackground.layer.masksToBounds = true
        
        btnCheckAnswerOutlet.layer.borderWidth = 1
        btnCheckAnswerOutlet.layer.borderColor = UIColor.gray.cgColor
        btnCheckAnswerOutlet.layer.cornerRadius = 7 // Ändra 10 till det värde du vill ha för rundningen
        btnCheckAnswerOutlet.layer.masksToBounds = true
        
        btnCheckAnswerOutlet.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
        btnCheckAnswerOutlet.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
        btnCheckAnswerOutlet.layer.shadowOffset = CGSize(width: 0, height: 5) // Ställ in skuggans position
        btnCheckAnswerOutlet.layer.shadowRadius = 5 // Ställ in hur utspridd skuggan ska vara
        btnCheckAnswerOutlet.clipsToBounds = false
    }
    
}

// Defines a notification name (timerDidReachZero) to observe when remainingTime reaches 0 = wordTimer reaches 0. Used to trigger functionality defined in timerDidReachZero function.
extension Notification.Name {
    static let timerDidReachZero = Notification.Name("timerDidReachZero")
}

