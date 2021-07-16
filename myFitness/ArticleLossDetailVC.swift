//
//  ArticleLossDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/16.
//

import UIKit
import WebKit

class ArticleLossDetailVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var articleWebURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: articleWebURL)!
        self.webView.load(URLRequest(url: url))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
