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
       
    
    @IBOutlet weak var labelWordTimer: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var labelWord: UILabel!
    @IBOutlet weak var textFieldTranslation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnCheckAnswer(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
