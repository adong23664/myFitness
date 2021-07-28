//
//  NewDiaryControllerTableViewController.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/11.
//

import UIKit
import CoreData
import Firebase

class NewDiaryController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var nameTextField: RoundedTextField!{
        didSet{
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    @IBOutlet var dateTextField: RoundedTextField! {
        didSet{
            dateTextField.tag = 2
            dateTextField.becomeFirstResponder()
            dateTextField.delegate = self
            dateTextField.text = "\(DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .short))"
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet{
        descriptionTextView.tag = 3
        descriptionTextView.layer.cornerRadius = 5.0
        descriptionTextView.layer.masksToBounds = true
        }
    }
    @IBOutlet var photoImageView: UIImageView!
    var diary: DiaryMO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
        }
        self.descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    @objc func tapDone(sender: Any) {
          self.view.endEditing(true)
      }  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField  = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    //當點擊view任何喔一處鍵盤收起
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let cameraAction = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "相簿", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            photoSourceRequestController.addAction(cancelAction)
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleToFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true

        let trailingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true

        let topConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true

        let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if nameTextField.text == "" || dateTextField.text == "" || descriptionTextView.text == ""  {
            let alertController = UIAlertController(title: "注意!", message: "填寫資料有空白", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        print("Name: \(nameTextField.text ?? "")")
        print("Type: \(dateTextField.text ?? "")")
        print("Description: \(descriptionTextView.text ?? "")")
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            diary = DiaryMO(context: appDelegate.persistentContainer.viewContext)
            diary.name = nameTextField.text
            diary.date = dateTextField.text
            diary.summary = descriptionTextView.text
            diary.timestamp = "\(Date())"
    
            
            if let diaryImage = photoImageView.image {
                diary.image = diaryImage.pngData()
            }
            print("Saving data to context ...")
            appDelegate.saveContext()
        }
        dismiss(animated: true, completion: nil)
        
    }


}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
