//
//  CheckStatusViewController.swift
//  Hyphen-Hacks-Hack
//
//  Created by Macbook on 10/20/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class CheckStatusViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var currentCords: [Double?] = []
    var notSafe = true

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        conditionLabel.text = "HOW IS YOUR CONDITION?"
        conditionLabel.font = conditionLabel.font.withSize(53)
    }
    @IBAction func yesButtonPressed(_ sender: Any) {
        notSafe = false
        locationManager.requestLocation()
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        notSafe = true
        locationManager.requestLocation()
        conditionLabel.text = "WE UPLOADED YOUR LOCATION. HELP IS COMING."
        conditionLabel.font = conditionLabel.font.withSize(20)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            currentCords = [lat as Double,long as Double]
            let lat: String = currentCords[0]?.description ?? ""
            let long: String = currentCords[1]?.description ?? ""
            let userDict: [String: Any] = UserDefaults.standard.object(forKey: "user") as! [String : Any]
            let id: String = userDict["id"] as! String
            let notSafeString = notSafe.description
            Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lat":lat,"natdis-long":long,"natdis-id":id,"natdis-notSafe":notSafeString])
            print("sending coordinates",lat,long,"with id",id,"Claiming notSafe:",notSafeString)
        } else {
            currentCords = []
            let lat: String = currentCords[0]?.description ?? ""
            let long: String = currentCords[1]?.description ?? ""
            let userDict: [String: Any] = UserDefaults.standard.object(forKey: "user") as! [String : Any]
            let id: String = userDict["id"] as! String
            Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lat":lat,"natdis-long":long,"natdis-id":id])
            print("sending coordinates",lat,long,"with id",id)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
