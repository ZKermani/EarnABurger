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
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var CurrentPaceLabel: UILabel!
    @IBOutlet weak var AvgPaceLabel: UILabel!
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    // Distance properties
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var startDate: Date!
    var traveledDistance: Double = 0
    var oldPosition: Double = 0
    var currentPace: Double = 0.0
    let updateStatsInterval: Int = 10 // In seconds
    
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
            locationManager.distanceFilter = 1 //10
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
    
    override func viewDidDisappear(_ animated: Bool) {
        //print("viewDidDisappear was triggered in LiveActivity")
        locationManager.stopUpdatingLocation()
        self.resetView()
    }
    
    func resetView() {
        timerCounting = false
        timer.invalidate()
        traveledDistance = 0.0
        oldPosition = 0.0
        currentPace = 0.0
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
        let alert = UIAlertController(title: title, message: "Are you done?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            
            // present activity summary first
            self.performSegue(withIdentifier: "ActivityToSummary", sender: self)
            //self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ActivityToSummary" {
            let destinationVC = segue.destination as! ActivitySummaryViewController
            destinationVC.Distance = DistanceLabel.text
            destinationVC.Time = TimerLabel.text
            destinationVC.AvgPace = AvgPaceLabel.text
        }
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
        
        if count % updateStatsInterval == 0 {
            // Update current pace at this point
            let distanceTraveledSinceLastTime = traveledDistance - oldPosition
            print("traveledDistance is \(traveledDistance). old position is \(oldPosition).")
            let elpasedTimeInMinutes = Double(updateStatsInterval) / 60
            let traveledDistanceInKM = distanceTraveledSinceLastTime / 1000
            currentPace = traveledDistanceInKM > 0 ? elpasedTimeInMinutes / traveledDistanceInKM : 0.0
            oldPosition = traveledDistance
            updateLabels()
        }
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
    
    func updateLabels() {
        let traveledDistanceInKm = traveledDistance / 1000
        let traveledDistanceString = String(format: "%.2f", traveledDistanceInKm)
        DistanceLabel.text = traveledDistanceString + " km"
        let elapsedTimeInMinutes = Double(count) / 60.0
        let averagePace = traveledDistance > 0.0 ? elapsedTimeInMinutes / traveledDistanceInKm : 0.0
        print("In updateLabels, traveleDistance is \(traveledDistance), elapsedTimeInMinutes is \(elapsedTimeInMinutes), and averagePace is \(averagePace)")
        let averagePaceString = String(format: "%.2f", averagePace) + " min/km"
        AvgPaceLabel.text = averagePaceString
        
        let currentPaceValue  = count < updateStatsInterval ? averagePace : currentPace
        let currentPaceString = String(format: "%.2f", currentPaceValue) + " min/km"
        CurrentPaceLabel.text = currentPaceString
    }
}
