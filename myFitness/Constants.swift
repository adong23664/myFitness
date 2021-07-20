//
//  Constants.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import Foundation
import UIKit

struct  Constants {
    struct  Storyboard {
        static let homeViewController = "HomeVC"
    }
    
    static func checkLogin(window: UIWindow) {
        if UserDefaults.standard.object(forKey: "email") == nil {
            //沒有login
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
            window.rootViewController = loginVC
        }
    }
}
