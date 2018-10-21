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
    
    let locationManager = CLLocationManager()
    var currentCords: [Double?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    @IBAction func yesButtonPressed(_ sender: Any) {
        Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lpoll":""])
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            currentCords = [lat as Double,long as Double]
            let lat: String = currentCords[0]?.description ?? ""
            let long: String = currentCords[1]?.description ?? ""
            let userDict: [String: Any] = UserDefaults.standard.object(forKey: "user") as! [String : Any]
            let id: String = userDict["id"] as! String
            Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lat":lat,"natdis-long":long,"natdis-id":id])
            print("sending coordinates",lat,long,"with id",id)
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
