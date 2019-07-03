//
//  FrameExViewController.swift
//  lazySacn
//
//  Created by Peter Pohlmann on 12.12.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

class FrameExViewController: UIViewController {
    var frameExtractor: FrameExtractor!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        frameExtractor = FrameExtractor()
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
