//
//  ShoulderDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class ShoulderDetailVC: UIViewController {
    
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

    }
    func getVideo(videoCode: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        shoulderWebView.load(URLRequest(url: url!))
    }



}
