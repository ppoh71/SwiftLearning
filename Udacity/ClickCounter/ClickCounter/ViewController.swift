//
//  ViewController.swift
//  ClickCounter
//
//  Created by Peter Pohlmann on 06.09.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label1: UILabel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }

    @IBAction func incrementCount(){
        self.count += 1
        self.label1.text = "\(self.count)"
    }
    
   
    
}

