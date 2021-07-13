//
//  BackDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import WebKit

class BackDetailVC: UIViewController {
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
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        backWebView.load(URLRequest(url: url!))
    }


}
