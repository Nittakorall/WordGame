//
//  HighScoreViewController.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-27.
//

import Foundation
import UIKit

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1 //change to the length och the highscorelist when it's created
            
            }

            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            
                return cell
            }
    }
}
