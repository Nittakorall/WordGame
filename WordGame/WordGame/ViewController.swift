//
//  ViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-25.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var btnStartGame: UIButton!
    @IBOutlet weak var btnHighScore: UIButton!
    @IBOutlet weak var btnCustomGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designBackground()
        designButtons(button: btnStartGame)
        designButtons(button: btnHighScore)
        designButtons(button: btnCustomGame)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToViewController(_ segue: UIStoryboardSegue) {
    }

    func designBackground() {
        imageViewBackground.backgroundColor = .clear
        imageViewBackground.layer.borderWidth = 4
        imageViewBackground.layer.borderColor = UIColor.black.cgColor
        imageViewBackground.layer.cornerRadius = 20 // Ändra 10 till det värde du vill ha för rundningen
        imageViewBackground.layer.masksToBounds = true
        
//        btnStartGame.layer.borderWidth = 1
//        btnStartGame.layer.borderColor = UIColor.gray.cgColor
//        btnStartGame.layer.cornerRadius = 7 // Ändra 10 till det värde du vill ha för rundningen
//        btnStartGame.layer.masksToBounds = true
//        
//        btnStartGame.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
//        btnStartGame.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
//        btnStartGame.layer.shadowOffset = CGSize(width: 0, height: 5) // Ställ in skuggans position
//        btnStartGame.layer.shadowRadius = 5 // Ställ in hur utspridd skuggan ska vara
//        btnStartGame.clipsToBounds = false
//        
//        btnHighScore.layer.borderWidth = 1
//        btnHighScore.layer.borderColor = UIColor.gray.cgColor
//        btnHighScore.layer.cornerRadius = 50 // Ändra 10 till det värde du vill ha för rundningen
//        btnHighScore.layer.masksToBounds = true
//        
//        btnHighScore.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
//        btnHighScore.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
//        btnHighScore.layer.shadowOffset = CGSize(width: 0, height: 5) // Ställ in skuggans position
//        btnHighScore.layer.shadowRadius = 5 // Ställ in hur utspridd skuggan ska vara
//        btnHighScore.clipsToBounds = false
//        
//        btnCustomGame.layer.borderWidth = 1
//        btnCustomGame.layer.borderColor = UIColor.gray.cgColor
//        btnCustomGame.layer.cornerRadius = 50 // Ändra 10 till det värde du vill ha för rundningen
//        btnCustomGame.layer.masksToBounds = true
//        
//        btnCustomGame.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
//        btnCustomGame.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
//        btnCustomGame.layer.shadowOffset = CGSize(width: 0, height: 5) // Ställ in skuggans position
//        btnCustomGame.layer.shadowRadius = 5 // Ställ in hur utspridd skuggan ska vara
//        btnCustomGame.clipsToBounds = false
    }
    
    func designButtons(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 7 // Ändra 10 till det värde du vill ha för rundningen
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor // Ställ in skuggans färg
        button.layer.shadowOpacity = 1 // Ställ in skuggans opacitet (0 till 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 3) // Ställ in skuggans position
        button.layer.shadowRadius = 3 // Ställ in hur utspridd skuggan ska vara
        button.clipsToBounds = false
    }

}

