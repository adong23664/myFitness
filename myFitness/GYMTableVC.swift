//
//  GYMTableVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/8.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseUI
import CoreData


class GYMTableVC: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    
    var db: Firestore!
    var gyms:[Gym] = []
    var searchResults: [Gym] = []
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 30.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font:customFont]
        }
        navigationController?.hidesBarsOnSwipe = true
        self.db = Firestore.firestore()
        self.loadData()
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search Gym"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
    }
    
    func filterContent(for searchText: String) {
        searchResults = gyms.filter({ (gym)-> Bool in
            let name =  gym.name, location = gym.location
            let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    
    func loadData() {
        self.db.collection("Gym").getDocuments { snapshot, error in
            if let e = error {
                print("error \(e)")
            }
            guard let data = snapshot else {return}
            for document in data.documents {
                let gym = Gym()
                gym.name = document.data()["name"] as! String
                gym.location = document.data()["location"] as! String
                gym.image = document.data()["image"] as! String
                gym.phone = document.data()["phone"] as! String
                gym.description = document.data()["description"] as! String
                self.gyms.append(gym)
            }
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        } else {
            return gyms.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymcell", for: indexPath) as! GYMTableViewCell
        
        let gym = (searchController.isActive) ? searchResults[indexPath.row] : gyms[indexPath.row]
        cell.nameLabel.text = gym.name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("GYM/\(gym.image).jpeg")
        cell.thumbnailImageView.sd_setImage(with: ref)
        
        cell.locationLabel.text = gym.location
        return cell
    }
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("選\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)// 閃一下
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGymDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! GYMDetailVC
                destinationController.gym = (searchController.isActive) ? searchResults[indexPath.row]: gyms[indexPath.row]
            }
        }
    }

}
