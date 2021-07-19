//
//  GYM.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/9.
//

import Foundation

class Gym {
    var name: String
    var location: String
    var image: String
    var phone: String
    var description: String
    
    init(name: String, location: String, image: String, phone: String, description: String) {
        self.name = name
        self.location = location
        self.image = image
        self.phone = phone
        self.description = description
    }
    convenience init(){
        self.init (name: "", location: "", image: "", phone: "", description: "")
    }
    
}
