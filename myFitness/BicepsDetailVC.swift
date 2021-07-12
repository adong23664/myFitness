//
//  BicepsDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class BicepsDetailVC: UIViewController {
    
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
    }
    func getVideo(videoCode: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        bicepsWebView.load(URLRequest(url: url!))
    }

}
