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
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        // Add the following keys to a constants file
        db.collection("Activities").addDocument(data: [
            "Distance": Distance!,
            "Speed": AvgPace!
        ]) { err in
            if let err = err {
                print("Error saving activitiy: \(err)")
            } else {
                print("Activity saved successfully")
            }
        }
    }
}
