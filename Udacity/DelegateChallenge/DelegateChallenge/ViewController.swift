//
//  ViewController.swift
//  DelegateChallenge
//
//  Created by Peter Pohlmann on 10.09.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var cashField: UITextField!
    @IBOutlet weak var switchField: UITextField!
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBAction func switched(_ sender: UISwitch) {
        
        if sender.isOn{
            switchField.isEnabled = true
        }
        else{
            switchField.isEnabled = false
        }
        
    }
    
    let zipDelegate = ZipCodeDelegate()
    let dollarSignDelegate = DollarSignDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.cashField.keyboardType = UIKeyboardType.decimalPad
         self.cashField.delegate = dollarSignDelegate
         self.zipField.delegate = zipDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

