//
//  BicepsDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class BicepsDetailVC: UIViewController , WKNavigationDelegate{
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var bicepsWebView: WKWebView!
    @IBOutlet weak var bicepsstepLabel: UILabel!
    @IBOutlet weak var bicepsMainImage: UIImageView!
    var bicepsVideoCode = ""
    var bicepsstep = ""
    var bicepsMainImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(videoCode:"\(bicepsVideoCode)" )
        bicepsstepLabel.text = bicepsstep
        bicepsMainImage.image = UIImage(named:bicepsMainImageName )
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    func getVideo(videoCode: String) {
        DispatchQueue.global().async {
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            DispatchQueue.main.async {
                self.bicepsWebView.load(URLRequest(url: url!))
                self.bicepsWebView.addSubview(self.spinner)
                self.spinner.startAnimating()
                self.bicepsWebView.navigationDelegate = self
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
