//
//  DiaryDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/10.
//

import UIKit

class DiaryDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: DiaryDetailHeaderView!

    var diary : DiaryMO!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        navigationItem.largeTitleDisplayMode = .never
        headerView.nameLabel.text = diary.name
        if let diaryImage = diary.image {
            headerView.headerImageView.image = UIImage(data: diaryImage as Data)
        }

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        if let mood = diary.mood {
            headerView.moodImageView.image = UIImage(named: mood)
        }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:DiaryDetailIconTextCell.self), for: indexPath) as! DiaryDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "pencil")?.withTintColor(.white,renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = diary.date
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:DiaryDetailIconTextCell.self), for: indexPath) as! DiaryDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "note")?.withTintColor(.white,renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = diary.summary
            cell.selectionStyle = .none
            
            return cell
        default:
            fatalError("Fail to instantiate the table view cell for detail view controller")
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMood" {
            let destinationController = segue.destination as! MoodVC
            destinationController.diary = diary
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moodDiary(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: {
            if let mood = segue.identifier {
                self.diary.mood = mood
                self.headerView.moodImageView.image = UIImage(named: mood)
                
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    appDelegate.saveContext()
                }
                
                let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                self.headerView.moodImageView.transform = scaleTransform
                self.headerView.moodImageView.alpha = 0
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                    self.headerView.moodImageView.transform = .identity
                    self.headerView.moodImageView.alpha = 1
                }, completion: nil)
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

