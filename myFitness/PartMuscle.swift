//
//  PartMuscle.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/18.
//

import Foundation

class PartMuscle {
    var name : String
    var image: String
    var video: String
    var step: String
    var mainImage: String
    
    init(name: String, image: String, video: String, step: String, mainImage: String) {
        self.name = name
        self.image = image
        self.video = video
        self.step = step
        self.mainImage = mainImage
    }
    
    convenience init() {
        self.init(name: "", image: "", video: "", step: "", mainImage: "")
    }
}


