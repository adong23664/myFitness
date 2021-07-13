//
//  ViewController.swift
//  myBMI
//
//  Created by 楊振東 on 2021/5/27.
//

import UIKit

class BMIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var BMINumber: UILabel!
    @IBOutlet weak var advice: UILabel!
    @IBOutlet weak var advice2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BMINumber.text = "";advice.text = "";advice2.text = ""
        heightField.tag = 1;heightField.delegate = self
        heightField.returnKeyType = .done
        
        weightField.tag = 2; weightField.delegate = self
        weightField.returnKeyType = .done
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    var bmi : Double?
    @IBAction func calBMI(_ sender: Any) {
        if let height = Double(heightField.text!), let weight = Double(weightField.text!){
             bmi = weight / ((height/100) * (height/100))
            BMINumber.text = String(format: "你的BMI是: %.2f",bmi!)
            if heightField.text == "0" || weightField.text == "0" {
                BMINumber.text = "身高體重需大於0"}
            else {
                guard let height = Double(heightField.text!), let weight = Double(weightField.text!)
                else {
                    BMINumber.text = "身高體重需大於0"
                    return
                    }
                
                if bmi! > 25 {
                    advice.text = "過重"
                    advice2.text = "123"
                } else if bmi! < 20 {
                    advice.text = "過輕"
                    advice2.text = "456"
                } else {
                    advice.text = "體重適中"
                    advice2.text = "789"
                }
            }
        }
        
    }
    
    @IBAction func clear(_ sender: Any) {
        heightField.text! = "";weightField.text! = "";BMINumber.text! = ""
        advice2.text! = ""
        advice.text = ""
        }
    
    @IBAction func sexchanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index  {
        case 0:   //男
            heightField.text = "";weightField.text = ""
            if heightField.text == "0" || weightField.text == "0" {
                BMINumber.text = ""}
            else {
                guard let height = Double(heightField.text!), let weight = Double(weightField.text!)
                else {
                    BMINumber.text = ""
                    return
                    }
                
                if bmi! > 25 {
                    advice.text = "過重"
                    advice2.text = "123"
                } else if bmi! < 20 {
                    advice.text = "過輕"
                    advice2.text = "456"
                } else {
                    advice.text = "體重適中"
                    advice2.text = "789"
                }
            }
          case 1:   //女
            heightField.text = "";weightField.text = ""
             if heightField.text == "0" || weightField.text == "0" {
                    BMINumber.text = ""}
                else {
                    guard let height = Double(heightField.text!), let weight = Double(weightField.text!) else {
                        BMINumber.text = ""
                        return
                        }
                    if bmi! > 22 {
                        advice.text = "過重"
                        advice2.text = "123"
                    } else if bmi! < 18 {
                        advice.text = "過輕"
                        advice2.text = "456"
                    } else {
                        advice.text = "體重適中"
                        advice2.text = "789"
                    }
                }
        default:
            advice.text = "輸入有誤"
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weightField.resignFirstResponder()
        heightField.resignFirstResponder()
        return true
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let heightField = self.view.viewWithTag(1) as? UITextField {
            heightField.resignFirstResponder()
        }
        if let heightField = self.view.viewWithTag(2) as? UITextField {
            heightField.resignFirstResponder()
        }
    }
}

