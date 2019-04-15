//
//  gameReferenceViewController.swift
//  ticTacToeGame
//
//  Created by муса магсумов on 08/03/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//
import CoreMotion
import UIKit

class gameReferenceViewController: UIViewController,UISplitViewControllerDelegate{
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet var circleViews: [CircleView]!
    @IBOutlet var crossViews: [CrossView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var behaviors = CardBehavior.init(in: animator)
    
   
   
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CMMotionManager.shared.isAccelerometerAvailable{
            behaviors.gravityBehavior.magnitude = 1.0
            CMMotionManager.shared.accelerometerUpdateInterval = 1/10
            CMMotionManager.shared.startAccelerometerUpdates(to: .main) { data ,error in
                if var x = data?.acceleration.x{
                    if var y = data?.acceleration.y{
                        switch UIDevice.current.orientation{
                        case .portrait: y *= -1
                        case .portraitUpsideDown:
                            break
                        case .landscapeLeft:
                            swap(&x, &y)
                        case .landscapeRight:
                            swap(&x, &y)
                            y *= -1
                        default : x = 0
                        y = 0
                        }
                        self.behaviors.gravityBehavior.gravityDirection = CGVector(dx: x, dy: y)
                        
                    }
                }
                
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        behaviors.gravityBehavior.magnitude = 0
        CMMotionManager.shared.stopAccelerometerUpdates()
    }
    
    
    
    @IBAction func newGameButton(_ sender:UIButton){
        for crossView in crossViews{
            behaviors.push(crossView)
            
        }
        for circleVIew in circleViews{
            behaviors.push(circleVIew)
        }
    }
    
    @IBOutlet weak var newGameButton: UIButton!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        mainLabel.layer.cornerRadius = 15
        mainLabel.layer.borderWidth = 2
        mainLabel.layer.borderColor = UIColor.clear.cgColor
        mainLabel.layer.masksToBounds = true
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.8, delay: 0, options: [], animations: { [weak self] in
                self?.mainLabel.layer.borderColor = UIColor.black.cgColor
                self?.mainLabel.layer.backgroundColor = UIColor.white.cgColor
                self?.mainLabel.transform = .identity
                
            })
        } else {
            // Fallback on earlier versions
        }
        
        newGameButton.layer.cornerRadius = 10
        newGameButton.layer.borderWidth = 4
        newGameButton.layer.masksToBounds = true
        newGameButton.layer.borderColor = UIColor.black.cgColor
        navigationController?.navigationBar.tintColor =  .clear
   
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        
        for crossView in crossViews{
            behaviors.addItem(crossView)
          
        }
        for circleVIew in circleViews{
          behaviors.addItem(circleVIew)
        }
        
    }

    
    
 
    
    
    
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if secondaryViewController is ticTacToeViewController {
            return true
        }
        return false
    }
    
    
    
    
    
    
    @IBAction func chooseTitle(_ sender: Any) {
        performSegue(withIdentifier: "Tic Tac Toe Game", sender: sender as? UIButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tic Tac Toe Game"{
            if let tttVC = segue.destination as? ticTacToeViewController{
                tttVC.title = "Tic Tac Toe Game"
            }
            
        }
        
        
    }
    
}


