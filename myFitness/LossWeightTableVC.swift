//
//  LossWeightTableVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/16.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI

class LossWeightTableVC: UITableViewController {
    
    var db: Firestore!
    
    var articles:[Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.db = Firestore.firestore()
        loadData()
    }
    
    func loadData() {
        self.db.collection("Lossarticle").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let article = Article()
                article.name = document.data()["name"] as! String
                article.address = document.data()["address"] as! String
                article.image = document.data()["image"] as! String
                article.source = document.data()["source"] as! String
                self.articles.append(article)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articlelosscell", for: indexPath)  as! ArticleLossTableViewCell
        cell.nameLabel?.text = articles[indexPath.row].name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("article/\(articles[indexPath.row].image).jpeg")
        cell.thumbnailImageView.sd_setImage(with: ref)

        
        cell.sourceLabel?.text = articles[indexPath.row].source
        
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLossArticle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ArticleLossDetailVC
                destinationController.article = articles[indexPath.row]
            }
        }
    }

}
