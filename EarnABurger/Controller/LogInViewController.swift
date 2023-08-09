//
//  LogInViewController.swift
//  
//
//  Created by Zahra Kermani on 09.08.23.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI Adjustments
        logInButton.layer.cornerRadius  = cornerRadiusMultiplier * logInButton.frame.height
        signUpButton.layer.cornerRadius = cornerRadiusMultiplier * signUpButton.frame.height
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginToSignup", sender: self)
    }
    
    
}
