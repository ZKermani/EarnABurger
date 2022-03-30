//
//  LiveActivityViewController.swift
//  EarnABurger
//
//  Created by Zahra Sadeghipoor on 3/30/22.
//

import UIKit

class LiveActivityViewController: UIViewController {

    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        endButton.layer.cornerRadius   = cornerRadiusMultiplier * endButton.frame.height
        pauseButton.layer.cornerRadius = cornerRadiusMultiplier * pauseButton.frame.height
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
