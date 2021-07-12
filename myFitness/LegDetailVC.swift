//
//  LagDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class LegDetailVC: UIViewController {
    @IBOutlet weak var legWebView: WKWebView!
    @IBOutlet weak var legstepLabel: UILabel!
    @IBOutlet weak var legMainImage: UIImageView!
    var legVideoCode = ""
    var legstep = ""
    var legMainImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(legVideoCode)" )
        legstepLabel.text = legstep
        legMainImage.image = UIImage(named:legMainImageName )

        
    }
    func getVideo(videoCode: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        legWebView.load(URLRequest(url: url!))
    }

 

}
