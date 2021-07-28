//
//  CaculateVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/14.
//

import UIKit
import MessageUI
import StoreKit
import Firebase

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
            let alert = UIAlertController(title: "", message: "感謝您使用瘋健身,若您有任何意見,歡迎與我聯繫", preferredStyle: .alert)
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
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(email)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "請至設定,綁定您的郵件才能使用此功能", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
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
    
    
    @IBAction func claimBtn(_ sender: Any) {
            let alert = UIAlertController(title: "聲明！", message: "本應用程式為教育目的,資料來源均來自網路,若有侵權請告知,必會立刻修改或下架", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
}
