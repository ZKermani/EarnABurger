//
//  HistoryViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 07.08.23.
//

import UIKit
import FirebaseFirestore

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var activities: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadActivities()
    }
    
    func loadActivities() {
        db.collection("Activities").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if let distance = document.data()["Distance"] as? String {
                        self.activities.append(distance)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        cell.textLabel?.text = activities[indexPath.row]
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
