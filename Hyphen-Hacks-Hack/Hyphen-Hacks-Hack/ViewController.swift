//
//  ViewController.swift
//  Hyphen-Hacks-Hack
//
//  Created by Macbook on 10/20/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import Alamofire

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = UserDefaults.standard.object(forKey: "user") as? [String: String]
        print(dict as Any)
        if (dict != nil) {
            print("user exists")
            performSegue(withIdentifier: "userExists", sender: self)
        }
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
}
