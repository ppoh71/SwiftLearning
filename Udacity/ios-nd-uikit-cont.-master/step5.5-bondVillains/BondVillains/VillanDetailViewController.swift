//
//  VillanDetailViewController.swift
//  BondVillains
//
//  Created by Peter Pohlmann on 23.10.18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class VillanDetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var villain: Villain!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        label.text = villain.name
        image.image = UIImage(named: villain.imageName)
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
