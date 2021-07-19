//
//  CaculateVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/14.
//

import UIKit
import MessageUI
import StoreKit

class CaculateVC: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let scene = self.view.window?.windowScene{
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    @IBAction func support() {
        if( MFMailComposeViewController.canSendMail())  {
            let alert = UIAlertController(title: "", message: "感謝您使用MyFitness,若您有任何意見,歡迎與我聯繫", preferredStyle: .alert)
            let email = UIAlertAction(title: "email", style: .default, handler: { (action) -> Void in
                let mailController = MFMailComposeViewController()
                mailController.mailComposeDelegate = self
                mailController.title = "意見詢問！"
                mailController.setSubject("意見詢問！")
                let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
                let product = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
                let messageBody = "<br/><br/><br/>Product:\(product!)(\(version!))"
                mailController.setMessageBody(messageBody, isHTML: true)
                mailController.setToRecipients(["adong23664@gmail.com"])
                self.present(mailController, animated: true, completion: nil)
            })
            alert.addAction(email)
            self.present(alert, animated: true, completion: nil)
        } else {
            //..
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result{
                      case .cancelled:
                          print("user cancelled")
                      case .failed:
                          print("user failed")
                      case .saved:
                          print("user saved email")
                      case .sent:
                          print("email sent")
                @unknown default:
                      print("other options")
              }
              self.dismiss(animated: true, completion: nil)
    }
}
