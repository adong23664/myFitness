//
//  StartVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import UIKit

class StartVC: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var setupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        setUpElements()
    }
    func setUpElements() {
        Utilities.styleHelloButton(loginButton)
        Utilities.styleFilledButton(setupButton)
    }
    


}
