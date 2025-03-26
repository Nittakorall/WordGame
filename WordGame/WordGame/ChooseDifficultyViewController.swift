//
//  ChooseDifficultyViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-26.
//

import UIKit

class ChooseDifficultyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let easyList = WordLists.shared.easyWordPairList
    let mediumList = WordLists.shared.mediumWordPairList
    let hardList = WordLists.shared.hardWordPairList
    
    var difficulties: [String] = ["---", "Easy", "Medium", "Hard"]
    var chosenDifficulty: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnDisplayInfo(_ sender: UIButton) {
        displayDifficultyAlert()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulties[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenDifficulty = row
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "startGameDifficulty" {
            if chosenDifficulty >= 1 && chosenDifficulty <= 3 {
                return true
            } else {
                let alert = UIAlertController(title: "Error", message: "Please choose a difficulty level.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameDifficulty" {
           if let destinationVC = segue.destination as? GameViewController {
               if chosenDifficulty == 1 {
                   destinationVC.wordPairs = easyList
                   destinationVC.remainingTime = 16
               } else if chosenDifficulty == 2 {
                   destinationVC.wordPairs = mediumList
                   destinationVC.remainingTime = 11
               } else if chosenDifficulty == 3 {
                   destinationVC.wordPairs = hardList
                   destinationVC.remainingTime = 11
               } else {
                   return
               }
           }
       }
    }
    
    func displayDifficultyAlert() {
        let alert = UIAlertController(title: "Difficulty Levels", message: "\nEasy\nSimple words for animals. 10 words and time limit for each word is 15 seconds.\n\nMedium\nMore complex words used in everyday life. 10 words and the time limit for each word is 10 seconds.\n\nHard\nVery comlex words used in a more academic setting. 10 words and the time limit for each word is 10 seconds.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

}
