//
//  GYMTableVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/8.
//

import UIKit
import Firebase
import FirebaseStorage

class GYMTableVC: UITableViewController {
    var db: Firestore!
    var gyms:[Gym] = []
    var gymURLs = ["https://firebasestorage.googleapis.com/v0/b/myfitness-dd143.appspot.com/o/GYM%2F%E6%88%90%E5%90%89%E6%80%9D%E6%B1%97%E6%9E%97%E5%8F%A3%E9%A4%A8.jpeg?alt=media&token=3b1edb1b-9729-40c4-9378-176c78b508ec","https://firebasestorage.googleapis.com/v0/b/myfitness-dd143.appspot.com/o/GYM%2F%E6%88%90%E5%90%89%E6%80%9D%E6%B1%97%E4%B8%89%E9%87%8D%E9%A4%A8.jpeg?alt=media&token=4abe804d-a49b-4ff3-b25a-04233197d0ba","https://firebasestorage.googleapis.com/v0/b/myfitness-dd143.appspot.com/o/GYM%2F%E6%88%90%E5%90%89%E6%80%9D%E6%B1%97%E6%96%B0%E8%8E%8A%E9%A4%A8.jpeg?alt=media&token=e0b25ad8-2203-4d05-8374-e31cd6b0f29f","https://firebasestorage.googleapis.com/v0/b/myfitness-dd143.appspot.com/o/GYM%2F%E6%88%90%E5%90%89%E6%80%9D%E6%B1%97%E8%98%86%E6%B4%B2%E9%A4%A8.jpeg?alt=media&token=5802e01d-4b9e-4f28-ba5b-6fec3a2f2ff9","https://firebasestorage.googleapis.com/v0/b/myfitness-dd143.appspot.com/o/GYM%2F%E6%88%90%E5%90%89%E6%80%9D%E6%B1%97%E4%B8%AD%E5%A3%A2%E9%A4%A8.jpeg?alt=media&token=56641d45-115f-4d11-b579-93d2f66f27a8"]
    
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
        return gyms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymcell", for: indexPath) as! GYMTableViewCell
        cell.nameLabel.text = gyms[indexPath.row].name
        
        if let imageURL = URL(string: gymURLs[indexPath.row]){
            let request = URLRequest(url: imageURL)
            let session = URLSession.shared
            //dataTask 預設放背景執行緒
            let task = session.dataTask(with: request){ data, response, error in
                if let e = error  {
                    print("error \(e)")
                    return
                }
                guard let imageData = data else {
                    return
                }
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = UIImage(data: imageData)
                }
            }
            task.resume()  //開始連線下載
        }
        cell.locationLabel.text = gyms[indexPath.row].location
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
                destinationController.gym = gyms[indexPath.row]
            }
        }
    }

}
