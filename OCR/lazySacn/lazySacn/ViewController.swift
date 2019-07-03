//
//  ViewController.swift
//  lazySacn
//
//  Created by Peter Pohlmann on 09.12.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    let image = UIImage(named: "test11")
    @IBOutlet weak var procImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    func test(){
        let start = CFAbsoluteTimeGetCurrent()
        if let image = image{
            if let tesseract = G8Tesseract(language: "eng") {
                // 2
                tesseract.engineMode = .tesseractCubeCombined
                // 3
                tesseract.pageSegmentationMode = .auto
                // 4
                tesseract.image = image
                // 5
                tesseract.recognize()
                // 6
                
                procImage.image = image
                textview.text = tesseract.recognizedText
                print("finish")
                print(tesseract)
                print(tesseract.recognizedText as Any)
                
            }
            
            let diff = CFAbsoluteTimeGetCurrent() - start
            timeLabel.text = "Took \(diff) seconds"
            print("Took \(diff) seconds")
        }
      
    }
    
}

