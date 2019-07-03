//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        print(TMDBClient.Endpoints.requestToken.url)
        setLoggingIn(true)
        TMDBClient.getRequestToken(completion: handleRequestToken(success:error:))
        //performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    @IBAction func loginViaWebsiteTapped() {
        TMDBClient.getRequestToken { (success, error) in
            if success{
                print("reuqest tokem ok")
                    UIApplication.shared.open(TMDBClient.Endpoints.webauth.url, options: [:], completionHandler: nil)
            }else{
                print("no request token for web auth")
            }
        }
    }
    
    func handleRequestToken(success: Bool, error: Error?){
        if success{
        print("1. handle Request")
        print(TMDBClient.Auth.requestToken)
             TMDBClient.login(username: self.emailTextField.text ?? "ppoh71@gmail.com", password: self.passwordTextField.text ?? "ingning", completion: self.handleLoginResponse(success:error:))
        } else{
            self.showLoginFailure(message: error?.localizedDescription ?? "test error")
            print("request token no success")
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?){
         if success{
        print("2 login success hanlder")
        print(TMDBClient.Auth.requestToken)
        TMDBClient.newSessionId(completion: handleSessionResponse(success:error:))
         }else{
            self.showLoginFailure(message: error?.localizedDescription ?? "test error")
            print("login succes failed")
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?){
        if success{
            print("got new session id")
            print(TMDBClient.Auth.sessionId)
            setLoggingIn(false)
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }else{
            self.showLoginFailure(message: error?.localizedDescription ?? "test error")
            print("new session id failed")
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool){
        
        
        if loggingIn{
            indicator.startAnimating()
        }else{
            indicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        loginViaWebsiteButton.isEnabled = !loggingIn
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
}

