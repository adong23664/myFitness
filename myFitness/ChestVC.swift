//
//  ChestVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class ChestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var db: Firestore!

    @IBOutlet weak var tableView: UITableView!
    
    var chests:[PartMuscle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        self.db = Firestore.firestore()
        loadData()

    }
    
    func loadData() {
        self.db.collection("Chest").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let chest = PartMuscle()
                chest.name = document.data()["name"] as! String
                chest.mainImage = document.data()["mainImage"] as! String
                chest.image = document.data()["image"] as! String
                chest.video = document.data()["video"] as! String
                chest.step = document.data()["step"] as! String
                self.chests.append(chest)
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chests.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chestcell",for: indexPath) as! ChestTableViewCell
        cell.chestNameLabel.text = chests[indexPath.row].name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("chest/\(chests[indexPath.row].image).jpeg")
        cell.chestImageView.sd_setImage(with: ref)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChestDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ChestDetailVC
                destinationController.chest = chests[indexPath.row]
                
            }
        }
    }
}

