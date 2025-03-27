//
//  ViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-25.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func highScoreButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let highScoreVC = storyboard.instantiateViewController(withIdentifier: "HighScoreViewController") as? HighScoreViewController {
            self.present(highScoreVC, animated: true, completion: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

