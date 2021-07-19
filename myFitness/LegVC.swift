//
//  LegVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class LegVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var db: Firestore!
    
    @IBOutlet weak var tableView: UITableView!
    
    var legs: [PartMuscle] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        self.db = Firestore.firestore()
        loadData()
    }
    
    func loadData() {
        self.db.collection("Leg").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let leg = PartMuscle()
                leg.name = document.data()["name"] as! String
                leg.mainImage = document.data()["mainImage"] as! String
                leg.image = document.data()["image"] as! String
                leg.video = document.data()["video"] as! String
                leg.step = document.data()["step"] as! String
                self.legs.append(leg)
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "legcell",for: indexPath) as! LegTableViewCell
        cell.legNameLabel.text = legs[indexPath.row].name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("leg/\(legs[indexPath.row].image).jpeg")
        cell.legImageView.sd_setImage(with: ref)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLegDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! LegDetailVC
                destinationController.leg = legs[indexPath.row]
            }
        }
    }
}
