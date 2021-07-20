//
//  SignUpVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
    }
    // Check the Fields and validate that the data is correct. if everything is correct, this method retuen nil, otherwise, return error message
    func validateFields()-> String? {
        // check all field are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in:  .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "所有欄位都需要填寫！"
        }
        
        //check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password is nit secure enough
            return "密碼至少8位英數字+1特殊符號(!@#*..)"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender:Any) {
        //Validate the Fields
        let error = validateFields()
        
        if error != nil {
            // there is something wrong with the fields, show error message
            showError(error!)
        } else {
            //creat cleaned versions of data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Creat user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error)  in
                if  error != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name": name, "email":email, "password":password, "uid" : result!.user.uid  ]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    UserDefaults.standard.set(name, forKey: "email")
                    UserDefaults.standard.synchronize()
                    self.transitionToHome()
                }
            }
        }

        
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    



}
