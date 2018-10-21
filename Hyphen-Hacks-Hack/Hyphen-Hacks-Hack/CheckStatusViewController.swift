//
//  CheckStatusViewController.swift
//  Hyphen-Hacks-Hack
//
//  Created by Macbook on 10/20/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import Alamofire

class CheckStatusViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func yesButtonPressed(_ sender: Any) {
        Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lpoll":""])
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-lpoll":""])
    }
    
}
