//
//  Note.swift
//  myFitness
//
//  Created by 楊振東 on 2021/6/17.
//

import Foundation
import UIKit
import CoreData

class Note : NSManagedObject{
    override func awakeFromInsert() {
        self.noteID = UUID().uuidString
    }
    
    override func prepareForDeletion() {
        if let imageName = self.imageName {
            let home = URL(fileURLWithPath: NSHomeDirectory())
            let doc = home.appendingPathComponent("Documents")
            let filePath = doc.appendingPathComponent(imageName)
            try? FileManager.default.removeItem(at: filePath)
        }
    }

    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.noteID == rhs.noteID
    }
    @NSManaged var text: String?
    @NSManaged var imageName: String?
    @NSManaged var noteID : String
    
    
    func image()->UIImage? {
        if let fileName = self.imageName {
            let home = URL(fileURLWithPath: NSHomeDirectory())
            let doc = home.appendingPathComponent("Documents")
            let filePath = doc.appendingPathComponent("\(fileName).jpg")
            return UIImage(contentsOfFile: filePath.path)
        }
        return nil
    }
    
    func thumbnail()->UIImage? {
        if let image = self.image() {
            let thumbnailSize = CGSize(width: 50, height: 50)
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(thumbnailSize, false, scale)
            let widthRatio = thumbnailSize.width / image.size.width
            let heightRatio = thumbnailSize.height / image.size.height
            let ratio = max(widthRatio,heightRatio)
            let imageSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
            
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: thumbnailSize.width, height: thumbnailSize.height))
            circlePath.addClip()
            
            image.draw(in: CGRect(x: -(imageSize.width - thumbnailSize.width)/50.0, y:(imageSize.height - thumbnailSize.height)/50.0, width: imageSize.width, height: imageSize.height))
            let smallImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return smallImage
        } else {
            return nil
        }
    }
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
