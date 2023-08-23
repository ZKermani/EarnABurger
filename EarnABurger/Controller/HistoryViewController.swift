//
//  HistoryViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 07.08.23.
//

import UIKit
import FirebaseFirestore

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var HistoryTabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var activities: [String] = []
    var activitySummaries: [ActivitySummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        HistoryTabBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityReusableCell")
        
        loadActivities()
    }
    
    func loadActivities() {
        
        db.collection("Activities").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let activityString = self.convertActivitySummaryToString(data)
                    self.activities.append(activityString)
                    
                    let activitySummary = self.loadActivitySummary(data)
                    self.activitySummaries.append(activitySummary)

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func convertActivitySummaryToString(_ activity: [String: Any]) -> String {
        var activityString = ""
        
        if let date = activity[K.FStore.dateField] as? String,
        let distance = activity[K.FStore.distanceField] as? String,
        let duration = activity[K.FStore.durationField] as? String,
           let avgPace = activity[K.FStore.avgPaceField] as? String {
            activityString = date + ": " + distance + ", " + duration + ", " + avgPace
        }
        
        return activityString
    }
    
    func loadActivitySummary(_ activity: [String: Any]) -> ActivitySummary {
        var activitySummary = ActivitySummary(date: "",
                                              distance: "",
                                              duration: "",
                                              avgPace: "")
        
        if let date = activity[K.FStore.dateField] as? String,
        let distance = activity[K.FStore.distanceField] as? String,
        let duration = activity[K.FStore.durationField] as? String,
           let avgPace = activity[K.FStore.avgPaceField] as? String {
            activitySummary = ActivitySummary(date: date,
                                              distance: distance,
                                              duration: duration,
                                              avgPace: avgPace)
        }
        
        return activitySummary
    }
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityReusableCell", for: indexPath) as! ActivityCellTableViewCell
        let activitySummary = activitySummaries[indexPath.row]
        cell.DateLabel.text = activitySummary.date
        cell.DistanbeLabel.text = activitySummary.distance
        cell.TimeLabel.text = activitySummary.duration
        cell.PaceLabel.text = activitySummary.avgPace
        
        cell.DistanceUnitLabel.text = "mi"
        cell.TimeUnitLabel.text = "time"
        cell.PaceUnitLabel.text = "min/mi"
        
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.text = activities[indexPath.row]
        //cell.imageView?.image = UIImage(systemName: "folder.fill")
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        // better to send the URL instead of last component
    //        selectedFolder = ExistingFolders[indexPath.row]
    //        self.performSegue(withIdentifier: "FoldersToFiles", sender: self)
    //    }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "FoldersToFiles" {
    //            let destinationVC = segue.destination as! FilesViewController
    //            destinationVC.folderPath = selectedFolder
    //        }
    //    }
    //
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            handleDeleteFolder(for: indexPath)
    //        }
    //    }
}


// MARK: - Tab bar delegate
extension HistoryViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if let title = item.title {
            
            switch title {
            case "Home":
                homeTabBarTouched()
            case "Start":
                self.performSegue(withIdentifier: "HistoryToStart", sender: self)
            case "Past Activities":
                break
            default:
                print("Unknown tab bar item!")
                return
            }
        }
    }

    func homeTabBarTouched() {
        performSegue(withIdentifier: "HistoryToHome", sender: self)
    }
}
