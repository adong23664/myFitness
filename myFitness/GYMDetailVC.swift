//
//  GYMDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/9.
//

import UIKit
import FirebaseUI

class GYMDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: GYMDetailHeaderView!
    
    var gym = Gym()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false
        
        headerView.nameLabel.text = gym.name
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("GYM/\(gym.image).jpeg")
        headerView.headerImageView.sd_setImage(with: ref)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Configure the navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
    

        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GymDetailIconTextCell.self), for: indexPath) as! GymDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "phone")?.withTintColor(.white,renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = gym.phone
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GymDetailIconTextCell.self), for: indexPath) as!GymDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.white,renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = gym.location
            cell.selectionStyle = .none
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GymDetailTextCell.self),for: indexPath) as! GymDetailTextCell
            cell.descriptionLabel.text = gym.description
            cell.selectionStyle = .none
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GymDetailSeparatorCell.self),for: indexPath) as! GymDetailSeparatorCell
            cell.titleLabel.text = "How To Get Here"
            cell.selectionStyle = .none
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GymDetailMapCell.self),for: indexPath) as! GymDetailMapCell
            cell.configure(location: gym.location)
            
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapVC
            destinationController.gym = gym
        }
    }
}
