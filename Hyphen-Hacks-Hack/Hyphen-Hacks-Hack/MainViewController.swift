//
//  MainViewController.swift
//  Hyphen-Hacks-Hack
//
//  Created by Macbook on 10/20/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var lpollTimer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lpollTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lpoll":""]).responseString(completionHandler: { (response:DataResponse<String>) in
                print("Received lpoll")
                self.goToAreYouOkay()
            })
        }
    }
    
    func goToAreYouOkay() {
        self.performSegue(withIdentifier: "areYouOkay", sender: self)
        lpollTimer?.invalidate()
        lpollTimer = nil
    }
    
    @IBAction func resetUserDefaults(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "user")
        print("UserDefaults reset")
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
}
