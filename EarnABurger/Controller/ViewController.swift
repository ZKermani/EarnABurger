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

class ViewController: UIViewController  {
    
    @IBOutlet weak var StatFrequencyPickerView: UIPickerView!
    @IBOutlet weak var ActivityPickerView: UIPickerView!
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    @IBOutlet weak var HomeTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI adjustments
        ProfileImageView.layer.cornerRadius = 0.5 * ProfileImageView.frame.height
        ProfileImageView.clipsToBounds = true
        
        // Delegates
        HomeTabBar.delegate = self
        assignPickerViewDelegate()
    }
    
    func assignPickerViewDelegate() {
        ActivityPickerView.dataSource = self
        ActivityPickerView.delegate = self

        StatFrequencyPickerView.dataSource = self
        StatFrequencyPickerView.delegate = self
    }
}

//MARK: - UIPickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == ActivityPickerView {
            return activities.count
        }
        if pickerView == StatFrequencyPickerView {
            return statsFrequencies.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var title: String?
        
        if pickerView == ActivityPickerView {
            title = activities[row]
        }
        if pickerView == StatFrequencyPickerView {
            title = statsFrequencies[row]
        }
        
        if let safeTitle = title {
            return NSAttributedString(string: safeTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        return nil
    }
}

// MARK: - Tab bar delegate
extension ViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if let title = item.title {
            
            switch title {
            case "Home":
                break
            case "Start":
                performSegue(withIdentifier: "StartToLiveActivity", sender: self)
            case "Past Activities":
                self.performSegue(withIdentifier: "HomeToHistory", sender: self)
            case "Log Out":
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                performSegue(withIdentifier: "MainToLogin", sender: self)
            default:
                print("Unknown tab bar item!")
                return
            }
        }
    }
}
