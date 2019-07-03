//
//  UIViewController+Extension.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        print("tapped logout")
        //
        TMDBClient.logout { (success, error) in
            if let success = success{
            print("logout success")
                TMDBClient.Auth.requestToken = ""
                TMDBClient.Auth.sessionId = ""
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }else{
                print("logout unsuccessful")
            }
        }
    }
    
}
