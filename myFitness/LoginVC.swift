//
//  LoginVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        setUpElements()
    

        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        
        //Validate Text Fields
        
        // Creat cleaned versions of the text filed
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Singing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error)  in
            if error != nil {
                //Couldn't sign in
                self.errorLabel.text = "帳號密碼錯誤或無此密碼"
                self.errorLabel.alpha = 1
            }
            else {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.synchronize()
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
