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
    
    @IBOutlet weak var SummaryTabBar: UITabBar!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Adjustments
        DeleteButton.layer.cornerRadius = cornerRadiusMultiplier * DeleteButton.frame.height
        SaveButton.layer.cornerRadius   = cornerRadiusMultiplier * SaveButton.frame.height
        
        SummaryTabBar.delegate = self
        
    }
    
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        // Add the following keys to a constants file
        let activitySummary = ActivitySummary(date: "11 Aug 2023",
                                              distance: Distance!,
                                              duration: "20 min",
                                              avgPace: AvgPace!)
//        db.collection("Activities").addDocument(data: [
//            "Distance": Distance!,
//            "Speed": AvgPace!
//        ]) { err in
        
        // TODO: This looks a bit excessive. Is there a better way of handling it?
        db.collection("Activities").addDocument(data: [
            K.FStore.dateField: activitySummary.date,
            K.FStore.distanceField: activitySummary.distance,
            K.FStore.durationField: activitySummary.duration,
            K.FStore.avgPaceField: activitySummary.avgPace
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

// MARK: - Tab bar delegate
extension ActivitySummaryViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if let title = item.title {
            
            switch title {
            case "Home":
                homeTabBarTouched()
            case "Start":
                break
            case "Past Activities":
                break //self.performSegue(withIdentifier: "StartToHistory", sender: self)
            default:
                print("Unknown tab bar item!")
                return
            }
        }
    }
    
    func homeTabBarTouched() {
        performSegue(withIdentifier: "SaveToHome", sender: self)
    }
}
