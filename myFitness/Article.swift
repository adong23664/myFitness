//
//  Article.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/19.
//

import Foundation
class Article {
    var name: String
    var image: String
    var source: String
    var address: String
    
    init(name: String, image: String, source: String, address: String){
        self.name = name
        self.image = image
        self.source = source
        self.address = address
    }
    
    convenience init(){
        self.init(name : "", image : "", source : "", address : "")
    
  }
  
}
