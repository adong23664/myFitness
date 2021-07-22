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
            let user = User()
            user.email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            user.password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            user.name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let data = ["name": user.name ?? "", "email": user.email ?? "","password": user.password ?? "" ]
            //Creat user
            Auth.auth().createUser(withEmail: user.email ?? "", password: user.password ?? "") { (result, error)  in
                if  error != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    let user = User()
                    db.collection("users").document(user.userID).setData(data) { error in
                        if let e = error {
                            print("error while adding data to firebase \(e)")
                            return
                        }
                        UserDefaults.standard.set(user.email, forKey: "email")
                        UserDefaults.standard.synchronize()
                        self.transitionToHome()
                    }
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
