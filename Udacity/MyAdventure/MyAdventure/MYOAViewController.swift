//
//  MYOAViewController.swift
//  MyAdventure
//
//  Created by Peter Pohlmann on 23.10.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

class MYOAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start over", style: .plain, target: self, action: #selector(startOver))
        // Do any additional setup after loading the view.
    }
    
    @objc func startOver(){
        print("go abck")
        if let navigationController = navigationController{
            navigationController.popToRootViewController(animated: true)
        }
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
