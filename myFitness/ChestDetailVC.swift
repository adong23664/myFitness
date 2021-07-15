//
//  ChestDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class ChestDetailVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet weak var chestWebView: WKWebView!
    @IBOutlet weak var cheststepLabel: UILabel!
    @IBOutlet weak var chestMainImage: UIImageView!
    var chestVideoCode = ""
    var cheststep = ""
    var chestMainImageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(chestVideoCode)" )
        cheststepLabel.text = cheststep
        chestMainImage.image = UIImage(named:chestMainImageName )
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    func getVideo(videoCode: String) {
        DispatchQueue.global().async {
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            DispatchQueue.main.async {
                self.chestWebView.load(URLRequest(url: url!))
                self.chestWebView.addSubview(self.spinner)
                self.spinner.startAnimating()
                self.chestWebView.navigationDelegate = self
                self.spinner.hidesWhenStopped = true
                
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
    



}
