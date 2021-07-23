//
//  CaculatorViewController.swift
//  myFitness
//
//  Created by 楊振東 on 2021/6/29.
//

import UIKit

class CaculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    let genders = ["請選擇","男", "女"]
    let ages = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"]
    let heights = ["100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200"]
    let weights = ["20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130"]
    var pickerViewGender = UIPickerView()
    var pickerViewAge = UIPickerView()
    var pickerViewHeight = UIPickerView()
    var pickerViewWeight = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerViewGender.delegate = self
        pickerViewGender.dataSource = self
        pickerViewAge.delegate = self
        pickerViewAge.dataSource = self
        pickerViewHeight.delegate = self
        pickerViewHeight.dataSource = self
        pickerViewWeight.delegate = self
        pickerViewWeight.dataSource = self
        genderTextField.inputView = pickerViewGender
        ageTextField.inputView = pickerViewAge
        heightTextField.inputView = pickerViewHeight
        weightTextField.inputView = pickerViewWeight
        genderTextField.inputAccessoryView = createToolbar()
        ageTextField.inputAccessoryView = createToolbar()
        heightTextField.inputAccessoryView = createToolbar()
        weightTextField.inputAccessoryView = createToolbar()
        pickerViewGender.tag = 1
        pickerViewAge.tag = 2
        pickerViewHeight.tag = 3
        pickerViewWeight.tag = 4
        
        pickerViewAge.selectRow(ages.count / 2, inComponent: 0, animated: false)
        pickerViewWeight.selectRow(weights.count / 2, inComponent: 0, animated: false)
        pickerViewHeight.selectRow(heights.count / 2, inComponent: 0, animated: false)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func createToolbar()-> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(cancelPickerView))
        toolbar.setItems([doneBtn],animated: true)
        
        return toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return genders.count
        case 2:
            return 100*ages.count
        case 3:
            return 100*heights.count
        case 4:
            return 100*weights.count
        default:
            return 1
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return genders[row]
        case 2:
            return ages[row % ages.count]
        case 3:
            return heights[row % heights.count]
        case 4:
            return weights[row % weights.count]
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            genderTextField.text = genders[row]
        case 2:
            ageTextField.text = ages[row % ages.count]
        case 3:
            heightTextField.text = heights[row % heights.count]
        case 4:
            weightTextField.text = weights[row % weights.count]
        default:
            return
        }
    }
    
    @objc func cancelPickerView() {
        genderTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    var bmr : Double?
    @IBAction func calBMR(_ sender: Any) {
        if genderTextField.text == "" || genderTextField.text == "請選擇" || ageTextField.text == "" || heightTextField.text == "" || weightTextField.text == ""  {
            return
        }else {
                if genderTextField.text == "男" {
                    if let age = Double(ageTextField.text!), let height = Double(heightTextField.text!), let weight = Double(weightTextField.text!){
                        bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5
                    }
                } else {
                    if let age = Double(ageTextField.text!), let height = Double(heightTextField.text!), let weight = Double(weightTextField.text!){
                        bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161
                    }
                }
                resultLabel.text = "BMR: \(bmr!),\n你的身體需要\(bmr!)卡路里才能維持其正常運轉."
            }
        }
    
    @IBAction func clearBMR(_ sender: Any) {
        genderTextField.text = ""
        ageTextField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
        resultLabel.text = ""
    }
    
    
}
