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
    var description: String
    var mood: String
    var timestamp: String
    
    
    init(name: String, image: String, date: String, description: String,mood: String = "", timestamp: String) {
        self.name = name
        self.image = image
        self.date = date
        self.description = description
        self.mood = mood
        self.timestamp = timestamp
    
        
    }
    
    convenience init() {
        self.init(name: "", image: "", date: "", description: "", mood: "", timestamp: "")
    }
}
