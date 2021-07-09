//
//  GYMTableVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/8.
//

import UIKit

class GYMTableVC: UITableViewController {
    var gyms:[Gym] = [
        Gym(name: "成吉思汗蘆洲館", location: "247新北市蘆洲區長安街156號B1", image: "成吉思汗蘆洲館", phone: " 02-82866600", description: "成吉思汗蘆洲創始館24HR365天全年無休"),
        Gym(name: "成吉思汗三重館", location: "241新北市三重區捷運路11號1F", image: "成吉思汗三重館", phone: "02-29880701", description: "全台灣唯一服務專業最頂級的健身訓練場地融合各項重量訓練有氧格鬥飛輪懸吊等專業設備的優良場館"),
        Gym(name: "成吉思汗新莊館", location: "242新北市新莊區中原路137號", image: "成吉思汗新莊館", phone: "02-89928388", description: "新莊旗艦館 總坪數1500坪\n國外訂製回台的專業健身器材，數量種類繁多，自由槓重量訓練、滑輪阻力訓練，機械式訓練，另外特製椅墊跟器材設計也更加符合亞洲人身形，訓練起來更得心應手，有效的加強肌肉感受度。\n全台最頂級的格鬥訓練場地，硬體訓練設備應有盡有，本館以綜合格鬥技為主，立技、摔技、寢技，且由專業教練指導授課。"),
        Gym(name: "成吉思汗林口館", location: "244新北市林口區仁愛路二段241-2號", image: "成吉思汗林口館", phone: "02-26069616", description: "成吉思汗林口旗艦店為24小時營業，全年無休\n為全台灣最高級、價格透明的健身場館\n結合各式專業訓練器材\n另含三大類別課程：有氧懸吊、飛輪及綜合格鬥\n課程可自由參加，不須另外收費"),
        Gym(name: "成吉思汗中壢館", location: "320桃園市中壢區環西路二段304號", image: "成吉思汗中壢館", phone: "03-4918665", description: "網路評價第一的優質健身房全中壢最大的健身房全台服務最好，最專業的健身房"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        cell.thumbnailImageView.image = UIImage(named: gyms[indexPath.row].image)
        cell.locationLabel.text = gyms[indexPath.row].location
        return cell
    }
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("選\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)// 閃一下
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGymDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! GYMDetailVC
                destinationController.gym = gyms[indexPath.row]
            }
        }
    }

}
