//
//  RandomColorizer.swift
//  TextFields
//
//  Created by Peter Pohlmann on 10.09.18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class RandomColorizer: NSObject, UITextFieldDelegate{
    
    func randomColor() -> UIColor{
        let redNumber = CGFloat(arc4random_uniform(256))
        let greenNumber = CGFloat(arc4random_uniform(256))
        let blueNumber = CGFloat(arc4random_uniform(256))
        
        print(redNumber)
        print(greenNumber)
        print(blueNumber)
        
        let randomColor = UIColor(red: redNumber/255, green: greenNumber/255, blue: blueNumber/255, alpha: 0.5)
        return randomColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newRandomColor = randomColor()
        textField.textColor = randomColor()
        
        print("new random color \(newRandomColor)")
        return true;
        
    }
    
}
