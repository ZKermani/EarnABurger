//
//  LiveActivityViewController.swift
//  EarnABurger
//
//  Created by Zahra Sadeghipoor on 3/30/22.
//

import UIKit
import MapKit

class LiveActivityViewController: UIViewController {

    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var TimerLabel: UILabel!
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    // Distance properties
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var startDate: Date!
    var traveledDistance: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI adjustments
        endButton.layer.cornerRadius   = cornerRadiusMultiplier * endButton.frame.height
        pauseButton.layer.cornerRadius = cornerRadiusMultiplier * pauseButton.frame.height
        
       // Location manager
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.distanceFilter = 10
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (!timerCounting) {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    @IBAction func pauseTapped(_ sender: UIButton) {
        
        var font = UIFont()
        var buttonTitle = pauseButton.titleLabel!.text
        
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            buttonTitle = "Resume"
            font = UIFont.systemFont(ofSize: pauseButton.titleLabel!.font.pointSize - 5)
        }
        else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            buttonTitle = "Pause"
            font = UIFont.systemFont(ofSize: pauseButton.titleLabel!.font.pointSize + 5)
        }
        let attributes = [NSAttributedString.Key.font: font]
        let title = NSAttributedString(string: buttonTitle!, attributes: attributes)
        pauseButton.setAttributedTitle(title, for: .normal)
        
    }
    
    @IBAction func endTapped(_ sender: Any) {
        let alert = UIAlertController(title: "End activity.", message: "Are you done?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            
            // present activity summary first
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Timer utilities
extension LiveActivityViewController {
    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

// MARK: - Location manager
extension LiveActivityViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startDate == nil {
            startDate = Date()
        } else {
            print("elapsedTime:", String(format: "%.0fs", Date().timeIntervalSince(startDate)))
        }
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            traveledDistance += lastLocation.distance(from: location)
            print("Traveled Distance:",  traveledDistance)
            print("Straight Distance:", startLocation.distance(from: locations.last!))
        }
        lastLocation = locations.last
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as? CLError)?.code == .denied {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
}
