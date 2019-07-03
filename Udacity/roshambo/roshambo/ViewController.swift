//
//  ViewController.swift
//  roshambo
//
//  Created by Peter Pohlmann on 09.09.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorButton: UIButton!
    
    @IBAction func rockAction(_ sender: Any) {
    
        let controller = storyboard?.instantiateViewController(withIdentifier: "RockResultViewController") as! RockResultController
        controller.player1  = rockButton.tag
        //self.show(controller, sender: self)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func scissorAction(_ sender: Any) {
        print("call 1")
        performSegue(withIdentifier: "scissorSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="paperSegue" {
            if let sender = sender as? UIButton{
                let controller = segue.destination as! RockResultController
                controller.player1 = sender.tag
            }
        }
        
        if segue.identifier=="scissorSegue" {
                let controller = segue.destination as! RockResultController
                controller.player1 = scissorButton.tag
        }
    }
}

