//
//  LoginVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit

class LoginVC: UIViewController {

//    @IBOutlet weak var fbLoginButton: FBLoginButton!
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

    }
    @IBAction func fbAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions:["public_profile","email"] ,from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }else {
                    if AccessToken.current != nil {
                    let request = GraphRequest(graphPath: "me", parameters:["fields":"email"])
                            request.start(completionHandler: { (connection, result, error) -> Void in
                                print(result)
                                let info = result as! Dictionary<String,AnyObject>
                                if let email = info["email"] {
                                    print("email  = \(email)")
                                    UserDefaults.standard.set(email, forKey: "email")
                                    UserDefaults.standard.synchronize()
                                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeVC
                                    self.view.window?.rootViewController = homeViewController
                                    self.view.window?.makeKeyAndVisible()
                                }
                            }
                        )
                    }
                }
            }
        }
        
    }
    
    func requestme()  {
            //先判斷是否有token存在,有Token表示使用者有login
            if AccessToken.current != nil {
            let request = GraphRequest(graphPath: "me", parameters:["fields":"email"])
                    request.start(completionHandler: { (connection, result, error) -> Void in
                        print(result)
                        let info = result as! Dictionary<String,AnyObject>
                        if let email = info["email"] {
                            print("email  = \(email)")
                        }
                    }
                )
            }
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
                print(email)
            }
        }
    }

}
