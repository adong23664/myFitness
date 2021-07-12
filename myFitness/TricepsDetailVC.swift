//
//  TricepsDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class TricepsDetailVC: UIViewController {
    
    @IBOutlet weak var tricepsWebView: WKWebView!
    @IBOutlet weak var tricepsstepLabel: UILabel!
    @IBOutlet weak var tricepsMainImage: UIImageView!
    var tricepsVideoCode = ""
    var tricepsstep = ""
    var tricepsMainImageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(tricepsVideoCode)" )
        tricepsstepLabel.text = tricepsstep
        tricepsMainImage.image = UIImage(named:tricepsMainImageName )

        
    }
    func getVideo(videoCode: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        tricepsWebView.load(URLRequest(url: url!))
    }

}
