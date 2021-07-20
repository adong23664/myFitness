//
//  Utilities.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/20.
//

import Foundation
import UIKit

class Utilities {

static func isPasswordValid(_ password: String) -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
    }
}
  
