//
//  NoteViewController.swift
//  myFitness
//
//  Created by 楊振東 on 2021/6/17.
//

import UIKit
protocol  NoteViewControllerDelegate : AnyObject {
    func didFinishUpdate(note: Note)
    func didFinishInsert(note: Note)
    func didFinishDelete(note: Note)
    func didFinishXXXXX(note: Note)
}
extension NoteViewControllerDelegate {
    func didFinishInsert(note: Note){}
    func didFinishDelete(note: Note){}
    func didFinishXXXXX(note: Note){}
}

class NoteViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var currentNote : Note!
    var isNewImage :Bool = false
    weak var delegate : NoteViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.borderWidth = 5
        self.imageView.layer.borderColor = UIColor.systemBlue.cgColor
        self.imageView.layer.cornerRadius = 30
        self.textView.text = self.currentNote.text
        self.imageView.image = self.currentNote.image()
        self.textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }


    @IBAction func done(_ sender: Any) {
        self.currentNote.text = self.textView.text
        if let image = imageView.image, self.isNewImage {
            let home = URL(fileURLWithPath: NSHomeDirectory())
            let doc = home.appendingPathComponent("Documents")
            let filePath = doc.appendingPathComponent("\(self.currentNote.noteID).jpg")
            if let imageData = image.jpegData(compressionQuality: 1){
                do {
                    try imageData.write(to: filePath, options: .atomic)
                    self.currentNote.imageName = "\(self.currentNote.noteID).jpg"
                } catch  {
                    print("寫檔有誤\(error)")
                }
            }
        }
        self.delegate?.didFinishUpdate(note: self.currentNote)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func camera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .savedPhotosAlbum
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
            self.isNewImage = true
        }
        self.dismiss(animated: true, completion: nil)
    }
}
