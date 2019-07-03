//
//  DollarSignDelegate.swift
//  DelegateChallenge
//
//  Created by Peter Pohlmann on 10.09.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import Foundation
import UIKit

class DollarSignDelegate: NSObject, UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var number = ""
        var newNumber = ""
        var currNumber: NSNumber = 0
        var backspace = false
        
        //check for backspace
        if (range.length == 1 && string.isEmpty){
            print("Used Backspace")
            backspace = true
        }
        
        if Int(string) != nil{
            number =  string
            
            if let textFieldText = textField.text  {
                var inputText = textFieldText
                inputText = inputText.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                inputText = inputText.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                inputText = inputText.replacingOccurrences(of: "$", with: "", options: .literal, range: nil)
                newNumber.append(inputText)
                newNumber.append(number)
               
                if let _currenyNumber = Double(newNumber){
                    currNumber = (_currenyNumber/100) as NSNumber
                    
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    formatter.minimumIntegerDigits = 2
                    let finalPrice = formatter.string(from: currNumber) // "$123.44"
                    print("finalPrice \(String(describing: finalPrice))")
                    
                    if let displayPrice = finalPrice{
                        textField.text = displayPrice as String
                    }
                }
            }
        }
        
        if backspace == true{
            return true
        } else{
            return false
        }
    }
}

