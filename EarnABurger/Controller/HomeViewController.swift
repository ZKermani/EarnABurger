//
//  HomeViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 18.08.23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var HomeTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HomeTabBar.delegate = self
    }
}

// MARK: - Tab bar delegate
extension HomeViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if let title = item.title {
            
            switch title {
            case "Home":
                break
            case "Start":
                performSegue(withIdentifier: "HomeToStart", sender: self)
            case "Past Activities":
                self.performSegue(withIdentifier: "HomeToHistory", sender: self)
            case "Log Out":
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                performSegue(withIdentifier: "HomeToLogin", sender: self)
            default:
                print("Unknown tab bar item!")
                return
            }
        }
    }
}
