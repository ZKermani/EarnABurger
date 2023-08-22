//
//  HomeViewController.swift
//  EarnABurger
//
//  Created by Zahra Kermani on 18.08.23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var HomeTabBar: UITabBar!
    @IBOutlet weak var ProfilePicImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfilePicImageView.layer.cornerRadius = 0.5 * ProfilePicImageView.frame.height
        ProfilePicImageView.clipsToBounds      = true

        HomeTabBar.delegate = self
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
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
