//
//  SignUpViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 09.08.23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI Adjustments
        SignUpButton.layer.cornerRadius = cornerRadiusMultiplier * SignUpButton.frame.height
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.handleSignUpError()
                }
                else {
                    self.handleSuccessfulSignUp()
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
    
    func handleSignUpError() {
        let title = "An error occurred!"
        let message = "Please try again."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //alert.view.tintColor = .white
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleSuccessfulSignUp() {
        
        // With this UserDefaults set, the user will stay logged in unless they log out.
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        
        let title = "Successful Sign Up!"
        let message = "You will be redirected to the activitiy page."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //alert.view.tintColor = .white
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.performSegue(withIdentifier: "SignupToMain", sender: self)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
