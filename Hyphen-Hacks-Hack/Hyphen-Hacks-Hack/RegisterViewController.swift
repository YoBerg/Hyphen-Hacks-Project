//
//  RegisterViewController.swift
//  Hyphen-Hacks-Hack
//
//  Created by Macbook on 10/20/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPickerData = pickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        bloodTypePickerView.dataSource = self
        bloodTypePickerView.delegate = self
    }
    
    let pickerData = ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
    var selectedPickerData: String = "A+"
    
    @IBOutlet weak var nameTextField: ClosableTextField!
    @IBOutlet weak var ageTextField: ClosableTextField!
    @IBOutlet weak var homeAddressTextField: ClosableTextField!
    @IBOutlet weak var bloodTypePickerView: UIPickerView!
    @IBOutlet weak var specneedsTextField: ClosableTextField!
    @IBOutlet weak var otherTextField: ClosableTextField!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var id: String = ""
        Alamofire.request(Constants.serverURL.serverURL, method: .post, parameters: [:], headers: ["natdis-name":nameTextField.text!,"natdis-age":ageTextField.text!,"natdis-homeaddr":homeAddressTextField.text!,"natdis-bloodtype":selectedPickerData,"natdis-specneeds":specneedsTextField.text!,"natdis-other":otherTextField.text!,"natdis-act":"REG"]).responseString { (response:DataResponse<String>) in
            let responseString = response.description
            print("Response:",responseString)
            if (responseString.components(separatedBy: ":")[0] == "SUCCESS") {
                id = responseString.substring(from: 9)
                UserDefaults.standard.set(["name":self.nameTextField.text!,"id":id], forKey: "user")
                print("->Saved id",id,"to user defaults")
                self.performSegue(withIdentifier: "saveComplete", sender: self)
            }
        }
    }
    
    @IBOutlet weak var gradientView: UIView!
    var gradientLayer: CAGradientLayer!
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        

        let grey = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        let yellow = UIColor(red: 247/255.0, green: 247/255.0, blue: 195/255.0, alpha: 1)
        
        gradientLayer.colors = [yellow.cgColor, grey.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func unwindWithSegue(segue: UIStoryboardSegue) {
    }
}
