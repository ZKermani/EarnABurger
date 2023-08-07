//
//  ActivitySummaryViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 07.08.23.
//

import UIKit
import FirebaseFirestore

class ActivitySummaryViewController: UIViewController {
    
    var Distance: String?
    var Time: String?
    var AvgPace: String?
    
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Adjustments
        DeleteButton.layer.cornerRadius = cornerRadiusMultiplier * DeleteButton.frame.height
        SaveButton.layer.cornerRadius   = cornerRadiusMultiplier * SaveButton.frame.height
        
    }
    
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        // Add the following keys to a constants file
        db.collection("Activities").addDocument(data: [
            "Distance": Distance!,
            "Speed": AvgPace!
        ]) { err in
            var message = ""
            if let err = err {
                print("Error saving activitiy: \(err)")
                message = "Error saving activitiy: \(err)"
            } else {
                print("Activity saved successfully")
                message =  "Activity saved successfully."
            }
            
            let alert = UIAlertController(title: self.title, message: message, preferredStyle: .alert)
            //alert.view.tintColor = .white
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
