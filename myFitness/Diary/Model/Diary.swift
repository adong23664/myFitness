//
//  Diary.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/10.
//

import Foundation

class Diary {
    var name: String
    var image: String
    var date: String
    var isLike: Bool
    var description: String
    var mood: String
    
    init(name: String, image: String, date: String, isLike:Bool, description: String,mood: String = "") {
        self.name = name
        self.image = image
        self.date = date
        self.isLike = isLike
        self.description = description
        self.mood = mood
        
    }
    
    convenience init() {
        self.init(name: "", image: "", date: "", isLike: false, description: "")
    }
}
