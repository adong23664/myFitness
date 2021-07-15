//
//  BackDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class BackDetailVC: UIViewController , WKNavigationDelegate{
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet weak var backWebView: WKWebView!
    @IBOutlet weak var backstepLabel: UILabel!
    @IBOutlet weak var backMainImage: UIImageView!
    var backVideoCode = ""
    var backstep = ""
    var backMainImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(backVideoCode)" )
        backstepLabel.text = backstep
        backMainImage.image = UIImage(named:backMainImageName )
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    func getVideo(videoCode: String) {
        DispatchQueue.global().async {
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            DispatchQueue.main.async {
                self.backWebView.load(URLRequest(url: url!))
                self.backWebView.addSubview(self.spinner)
                self.spinner.startAnimating()
                self.backWebView.navigationDelegate = self
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
