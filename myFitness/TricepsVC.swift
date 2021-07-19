//
//  TricepsVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class TricepsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var db: Firestore!
    @IBOutlet weak var tableView: UITableView!
    
    var tricepses : [PartMuscle] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white

        self.db = Firestore.firestore()
        loadData()
    }
    
    func loadData() {
        self.db.collection("Triceps").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let triceps = PartMuscle()
                triceps.name = document.data()["name"] as! String
                triceps.mainImage = document.data()["mainImage"] as! String
                triceps.image = document.data()["image"] as! String
                triceps.video = document.data()["video"] as! String
                triceps.step = document.data()["step"] as! String
                self.tricepses.append(triceps)
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tricepses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tricepscell",for: indexPath) as! TricepsTableViewCell
        cell.tricepsNameLabel.text = tricepses[indexPath.row].name
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("triceps/\(tricepses[indexPath.row].image).jpeg")
        cell.tricepsImageView.sd_setImage(with: ref)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTricepsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! TricepsDetailVC
                destinationController.triceps = tricepses[indexPath.row]
            }
        }
    }
}
