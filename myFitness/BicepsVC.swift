//
//  BicepsVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class BicepsVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    var db: Firestore!
    @IBOutlet weak var tableView: UITableView!
    
    var bicepses : [PartMuscle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        self.db = Firestore.firestore()
        loadData()
    }
    
    func loadData() {
        self.db.collection("Biceps").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let biceps = PartMuscle()
                biceps.name = document.data()["name"] as! String
                biceps.mainImage = document.data()["mainImage"] as! String
                biceps.image = document.data()["image"] as! String
                biceps.video = document.data()["video"] as! String
                biceps.step = document.data()["step"] as! String
                self.bicepses.append(biceps)
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bicepses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bicepscell",for: indexPath) as! BicepsTableViewCell
        cell.bicepsNameLabel.text = bicepses[indexPath.row].name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("biceps/\(bicepses[indexPath.row].image).jpeg")
        cell.bicepsImageView.sd_setImage(with: ref)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBicepsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! BicepsDetailVC
                destinationController.biceps = bicepses[indexPath.row]
            }
        }
    }

}
