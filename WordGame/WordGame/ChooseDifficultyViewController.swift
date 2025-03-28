//
//  ChooseDifficultyViewController.swift
//  WordGame
//
//  Created by KiwiComp on 2025-03-26.
//

import UIKit

class ChooseDifficultyViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var btnStartGame: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    
    
    
    
    // Default lists for the different difficulty levels. Singletons.
    let easyList = WordLists.shared.easyWordPairList
    let mediumList = WordLists.shared.mediumWordPairList
    let hardList = WordLists.shared.hardWordPairList
    
    // List of strings to be displayed in the pickerView.
    var difficulties: [String] = ["---", "Easy", "Medium", "Hard", "Custom"]
    // Variable to register which option is chosen in pickerView.
    var chosenDifficulty: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSetup()
    }
    
    
    @IBAction func btnDisplayInfo(_ sender: UIButton) {
        displayDifficultyAlert()
    }
    
    // Needed for DataSource, number of columns in pickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Needed for DataSource, number of rows in pickerView. Uses the difficulties list.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulties.count
    }
    // Can be used because of Delegate. Setting text for the alternatives in the pickerView.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulties[row]
    }
    // Can be used because of Delegate. Takes int for selected row and sets chosenDifficulty.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenDifficulty = row
    }
    
    // When Start Game btn is pressed and segue triggered, this function checks which VC to show depending on chosen alternative in pickerView.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "startGameDifficulty" {
            if chosenDifficulty >= 1 && chosenDifficulty <= 3 {
                // Segue to GameVC for default-alternatives.
                return true // Triggers  startGameDifficulty-segue.
            } else if chosenDifficulty == 4 {
                // Use different segue to another VC for the custom alternative.
                self.performSegue(withIdentifier: "startCustom", sender: sender)
                return false // Does not triger startGameDifficulty-segue.
            } else {
                // Popup if an alternative has not been chosen.
                let alert = UIAlertController(title: "Error", message: "Please choose a difficulty level.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false // Does not triger startGameDifficulty-segue.
            }
        }
        return true // Apparently good to have for other potential segues.
    }
    
    // Sends data to next VC, sets the variables to different values depending on alternative in pickerView.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameDifficulty" {
           if let destinationVC = segue.destination as? GameViewController {
               if chosenDifficulty == 1 {
                   destinationVC.wordPairs = easyList
                   destinationVC.remainingTime = 16
                   destinationVC.difficulty = chosenDifficulty
               } else if chosenDifficulty == 2 {
                   destinationVC.wordPairs = mediumList
                   destinationVC.remainingTime = 11
                   destinationVC.difficulty = chosenDifficulty
               } else if chosenDifficulty == 3 {
                   destinationVC.wordPairs = hardList
                   destinationVC.remainingTime = 11
                   destinationVC.difficulty = chosenDifficulty
               } else {
                   return
               }
           }
       }
    }
    
    // Displays popup with information on difficulty levels when info btn is pressed.
    func displayDifficultyAlert() {
        let alert = UIAlertController(title: "Difficulty Levels", message: "\nEasy\nSimple words for animals. 10 words and time limit for each word is 15 seconds.\n\nMedium\nMore complex words used in everyday life. 10 words and the time limit for each word is 10 seconds.\n\nHard\nVery comlex words used in a more academic setting. 10 words and the time limit for each word is 10 seconds.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func designSetup() {
        imageViewBackground.backgroundColor = .clear
        imageViewBackground.layer.borderWidth = 4
        imageViewBackground.layer.borderColor = UIColor.black.cgColor
        imageViewBackground.layer.cornerRadius = 20 // Ändra 10 till det värde du vill ha för rundningen
        imageViewBackground.layer.masksToBounds = true
        
        btnInfo.layer.borderWidth = 1
        btnInfo.layer.borderColor = UIColor.gray.cgColor
        btnInfo.layer.cornerRadius = 7 // Ändra 10 till det värde du vill ha för rundningen
        btnInfo.layer.masksToBounds = true
        
        btnInfo.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
        btnInfo.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
        btnInfo.layer.shadowOffset = CGSize(width: 0, height: 5) // Ställ in skuggans position
        btnInfo.layer.shadowRadius = 5 // Ställ in hur utspridd skuggan ska vara
        btnInfo.clipsToBounds = false
        
        btnStartGame.layer.borderWidth = 1
        btnStartGame.layer.borderColor = UIColor.gray.cgColor
        btnStartGame.layer.cornerRadius = 50 // Ändra 10 till det värde du vill ha för rundningen
        btnStartGame.layer.masksToBounds = true
        
        btnStartGame.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
        btnStartGame.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
        btnStartGame.layer.shadowOffset = CGSize(width: 0, height: 5) // Ställ in skuggans position
        btnStartGame.layer.shadowRadius = 5 // Ställ in hur utspridd skuggan ska vara
        btnStartGame.clipsToBounds = false
    }

}
