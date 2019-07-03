//
//  ZipCodeDelegate.swift
//  DelegateChallenge
//
//  Created by Peter Pohlmann on 10.09.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import Foundation
import UIKit

class ZipCodeDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var isInt = false
        var count = 0
        var backspace = false
        
        //check for backspace
        if (range.length == 1 && string.isEmpty){
            print("Used Backspace")
            backspace = true
        }
        
        //count string
        if let cnt = textField.text?.count{
            count = cnt
        } else {
            count = 0
        }
        
        //check if input is int
        if Int(string) != nil{
            isInt = true
        } else{
            isInt = false
        }
        
        if isInt == true && count < 5 || backspace == true{
            return true
        } else{
            return false
        }
    }
}
