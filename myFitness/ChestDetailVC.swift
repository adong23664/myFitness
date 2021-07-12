//
//  ChestDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class ChestDetailVC: UIViewController {
    @IBOutlet weak var chestWebView: WKWebView!
    @IBOutlet weak var cheststepLabel: UILabel!
    @IBOutlet weak var chestMainImage: UIImageView!
    var chestVideoCode = ""
    var cheststep = ""
    var chestMainImageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode:"\(chestVideoCode)" )
        cheststepLabel.text = cheststep
        chestMainImage.image = UIImage(named:chestMainImageName )
        
    }
    
    func getVideo(videoCode: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        chestWebView.load(URLRequest(url: url!))
    }
    



}
