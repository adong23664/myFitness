//
//  ShoulderDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class ShoulderDetailVC: UIViewController, WKNavigationDelegate {
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var shoulderWebView: WKWebView!
    @IBOutlet weak var shoulderstepLabel: UILabel!
    @IBOutlet weak var shoulderMainImage: UIImageView!
    var shoulderVideoCode = ""
    var shoulderstep = ""
    var shoulderMainImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(shoulderVideoCode)" )
        shoulderstepLabel.text = shoulderstep
        shoulderMainImage.image = UIImage(named:shoulderMainImageName )
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

    }
    func getVideo(videoCode: String) {
        DispatchQueue.global().async {
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            DispatchQueue.main.async {
                self.shoulderWebView.load(URLRequest(url: url!))
                self.shoulderWebView.addSubview(self.spinner)
                self.spinner.startAnimating()
                self.shoulderWebView.navigationDelegate = self
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
