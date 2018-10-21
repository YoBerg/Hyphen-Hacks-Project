//
//  MainViewController.swift
//  Hyphen-Hacks-Hack
//
//  Created by Macbook on 10/20/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    var lpollTimer: Timer? = nil
    var checkUserTimer: Timer? = nil
    
    let locationManager = CLLocationManager()
    
    var currentCords: [Double?] = []
     
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createGradientLayer()
        let dict = UserDefaults.standard.object(forKey: "user") as! [String: Any]
        self.nameLabel.text = dict["name"] as? String
        lpollTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
            Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lpoll":""]).responseString(completionHandler: { (response:DataResponse<String>) in
                if (response.description == "SUCCESS: True") {
                    self.locationManager.requestLocation()
                }
                print(response.description)
            })
        }
        
        checkUserTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (Timer) in
            let dict = UserDefaults.standard.object(forKey: "user") as? [String: String]
            if (dict == nil) {
                self.returnToMain()
            }
        }
    }
    
    func goToAreYouOkay() {
        self.performSegue(withIdentifier: "areYouOkay", sender: self)
        lpollTimer?.invalidate()
        lpollTimer = nil
        checkUserTimer?.invalidate()
        checkUserTimer = nil
    }
    
    func returnToMain() {
        lpollTimer?.invalidate()
        lpollTimer = nil
        checkUserTimer?.invalidate()
        checkUserTimer = nil
        self.performSegue(withIdentifier: "unwindToHomeSegue", sender: self)
    }
    
    @IBAction func resetUserDefaults(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "user")
        print("UserDefaults reset")
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
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
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var gradientView: UIView!
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        
        let grey = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
//        let blue = UIColor(red: 214/255.0, green: 228/255.0, blue: 255/255.0, alpha: 1)
        let blue = UIColor(red: 170/255.0, green: 200/255.0, blue: 255/255.0, alpha: 1)
        
        gradientLayer.colors = [grey.cgColor, blue.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
    }
    
}
