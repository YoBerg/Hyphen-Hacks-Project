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
        createGradientLayer()
        let dict = UserDefaults.standard.object(forKey: "user") as? [String: String]
        print(dict as Any)
        if (dict != nil) {
            print("user exists")
            performSegue(withIdentifier: "userExists", sender: self)
        }
    }
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var gradientView: UIView!
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let yellow = UIColor(red: 247/255.0, green: 247/255.0, blue: 195/255.0, alpha: 1)
        let blue = UIColor(red: 214/255.0, green: 228/255.0, blue: 255/255.0, alpha: 1)
        
        gradientLayer.colors = [blue.cgColor, yellow.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
    }
    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
    
    @IBAction func linkButtonPressed(_ sender: Any) {
        if let url = URL(string: "https://hackathon-nat-dis-hkibur.c9users.io/#") {
            UIApplication.shared.open(url, options: [:]) {
                boolean in
                // do something with the boolean
            }
        }
    }
    
}
