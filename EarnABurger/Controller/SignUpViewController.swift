//
//  SignUpViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 09.08.23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var SignUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI Adjustments
        SignUpButton.layer.cornerRadius = cornerRadiusMultiplier * SignUpButton.frame.height
    }
    

}
