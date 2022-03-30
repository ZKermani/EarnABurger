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
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var StatFrequencyPickerView: UIPickerView!
    @IBOutlet weak var ActivityPickerView: UIPickerView!
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    let cornerRadiusMultiplier = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ProfileImageView.layer.cornerRadius = cornerRadiusMultiplier * ProfileImageView.frame.height
        
        startButton.layer.cornerRadius = cornerRadiusMultiplier * startButton.frame.height
        
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
