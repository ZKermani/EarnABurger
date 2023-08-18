//
//  LogInViewController.swift
//  
//
//  Created by Zahra Kermani on 09.08.23.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI Adjustments
        logInButton.layer.cornerRadius  = cornerRadiusMultiplier * logInButton.frame.height
        signUpButton.layer.cornerRadius = cornerRadiusMultiplier * signUpButton.frame.height
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginToSignup", sender: self)
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print("Log in error is \(err)")
                    self.handleLogInError()
                }
                else {
                    self.handleSuccessfulLogIn()
                }
            }
        }
        else {
            // UIAlert: fill in both text fields
            handleEmptyEmailPasswordTextFields()
        }
    }
    
    func handleEmptyEmailPasswordTextFields() {
        let message = "Email and Password fields are mandatory."
        let alert = UIAlertController(title: self.title, message: message, preferredStyle: .alert)
        //alert.view.tintColor = .white
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLogInError() {
        let title = "An error occurred!"
        let message = "Please try again."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleSuccessfulLogIn() {
        // With this UserDefaults set, the user will stay logged in unless they log out.
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        performSegue(withIdentifier: "LoginToHome", sender: self)
    }
}
