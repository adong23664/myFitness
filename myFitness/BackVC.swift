//
//  BackVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/6.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class BackVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var db: Firestore!
    
    
    @IBOutlet weak var tableView: UITableView!
    var backs: [PartMuscle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        self.db = Firestore.firestore()
        loadData()
        
    }
    
    func loadData() {
        self.db.collection("Back").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let back = PartMuscle()
                back.name = document.data()["name"] as! String
                back.mainImage = document.data()["mainImage"] as! String
                back.image = document.data()["image"] as! String
                back.video = document.data()["video"] as! String
                back.step = document.data()["step"] as! String
                self.backs.append(back)
            }
            self.tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        backs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backcell",for: indexPath) as! BackTableViewCell
        cell.backNameLabel.text = backs[indexPath.row].name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("back/\(backs[indexPath.row].image).jpeg")
        cell.backImageView.sd_setImage(with: ref)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBackDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! BackDetailVC
                destinationController.back = backs[indexPath.row]
            }
        }
    }
}
