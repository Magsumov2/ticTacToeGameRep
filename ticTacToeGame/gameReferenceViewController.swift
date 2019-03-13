//
//  gameReferenceViewController.swift
//  ticTacToeGame
//
//  Created by муса магсумов on 08/03/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//

import UIKit

class gameReferenceViewController: UIViewController,UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    @IBOutlet weak var newGameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.layer.cornerRadius = 10
        newGameButton.layer.borderWidth = 5
        newGameButton.layer.masksToBounds = true
        newGameButton.layer.borderColor = UIColor.clear.cgColor
    

        
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if secondaryViewController is ticTacToeViewController {
            return true
        }
        return false
    }
    

   
    @IBAction func chooseTitle(_ sender: Any) {
        performSegue(withIdentifier: "choose Title", sender: sender as? UIButton)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choose Title"{
            _ = segue.destination as? ticTacToeViewController}
           
        }
    }


