//
//  ViewController.swift
//  EarnABurger
//
//  Created by Zahra Sadeghipoor on 3/28/22.
//

import UIKit

// App logos
// <a href="https://www.flaticon.com/free-icons/run" title="run icons">Run icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/burger" title="burger icons">Burger icons created by Freepik - Flaticon</a>

class ViewController: UIViewController {

    @IBOutlet weak var ProfileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ProfileImageView.layer.cornerRadius = 0.1 * ProfileImageView.frame.height
    }


}

