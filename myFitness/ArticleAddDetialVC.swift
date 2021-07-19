//
//  ArticleAddDetialVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/16.
//

import UIKit
import WebKit
import FirebaseUI

class ArticleAddDetialVC: UIViewController, WKNavigationDelegate {
    var article = Article()
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!


    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: article.address)!
        self.webView.load(URLRequest(url: url))
        self.webView.addSubview(self.spinner)
        self.spinner.startAnimating()
        self.webView.navigationDelegate = self
        self.spinner.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
    

}
