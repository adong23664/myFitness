//
//  LagDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class LegDetailVC: UIViewController, WKNavigationDelegate {
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet weak var legWebView: WKWebView!
    @IBOutlet weak var legstepLabel: UILabel!
    @IBOutlet weak var legMainImage: UIImageView!
    var leg = PartMuscle()

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(leg.video)" )
        legstepLabel.text = leg.step
        legMainImage.image = UIImage(named:leg.mainImage )
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        
    }
    func getVideo(videoCode: String) {
        DispatchQueue.global().async {
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            DispatchQueue.main.async {
                self.legWebView.load(URLRequest(url: url!))
                self.legWebView.addSubview(self.spinner)
                self.spinner.startAnimating()
                self.legWebView.navigationDelegate = self
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
