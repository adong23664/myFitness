//
//  AllVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/7.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class ShoulderVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    var db: Firestore!
    
    
    @IBOutlet weak var tableView: UITableView!
    var shoulders : [PartMuscle] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        self.db = Firestore.firestore()
        loadData()
    }
    
    func loadData() {
        self.db.collection("Shoulder").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let shoulder = PartMuscle()
                shoulder.name = document.data()["name"] as! String
                shoulder.mainImage = document.data()["mainImage"] as! String
                shoulder.image = document.data()["image"] as! String
                shoulder.video = document.data()["video"] as! String
                shoulder.step = document.data()["step"] as! String
                self.shoulders.append(shoulder)
            }
            self.tableView.reloadData()
        }
    }

  

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoulders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shouldercell",for: indexPath) as! ShoulderTableViewCell
        cell.shoulderNameLabel.text = shoulders[indexPath.row].name
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("shoulder/\(shoulders[indexPath.row].image).jpeg")
        cell.shoulderImageView.sd_setImage(with: ref)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShoulderDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ShoulderDetailVC
                destinationController.shoulder = shoulders[indexPath.row]

            }
        }
    }
}
