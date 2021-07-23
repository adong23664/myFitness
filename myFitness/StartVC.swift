//
//  StartVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import UIKit
import AVKit

class StartVC: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var setupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setUpElements()
        
        backgroundImageView.image = UIImage(named: "first")
                let blurEffect = UIBlurEffect(style: .dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                backgroundImageView.addSubview(blurEffectView)
    }
    func setUpElements() {
        Utilities.styleHelloButton(loginButton)
        Utilities.styleFilledButton(setupButton)
    }
}
    
