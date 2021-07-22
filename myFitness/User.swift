//
//  User.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/22.
//

import Foundation
import UIKit

class User {
    var name: String?
    var userID: String
    var email : String?
    var password: String?
    init() {
        self.userID = UUID().uuidString
    }
    func toData() ->[String: Any] {
        return ["name":self.name ?? "", "email": self.email ?? "", "password": self.password ?? "" ]
    }
}
