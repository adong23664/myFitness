//
//  DiaryDetailVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/10.
//

import UIKit

class DiaryDetailVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: DiaryDetailHeaderView!

    var diary = Diary()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        headerView.nameLabel.text = diary.name
        headerView.headerImageView.image = UIImage(named: diary.image)
        headerView.heartImageView.isHidden = (diary.isLike) ? false : true

        
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
