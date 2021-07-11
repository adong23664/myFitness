//
//  DiaryVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/10.
//

import UIKit

class DiaryVC: UITableViewController {
    

    
    var diarys:[Diary] = [
        Diary(name: "cat0", image: "cat0", date: "2021/07/01", isLike: false, description: "臣亮言：先帝創業未半，而中道崩殂。今天下三分，益州疲敝，此誠危急存亡之秋也！然侍衞之臣，不懈於內；忠志之士，忘身於外者，蓋追先帝之殊遇，欲報之於陛下也。誠宜開張聖聽，以光先帝遺德，恢弘志士之氣；不宜妄自菲薄，引喻失義，以塞忠諫之路也。宮中、府中，俱為一體；陟罰臧否，不宜異同。若有作奸、犯科，及為忠善者，宜付有司，論其刑賞，以昭陛下平明之治；不宜偏私，使內外異法也。"),
        Diary(name: "cat1", image: "cat1", date: "2021/07/02", isLike: false, description: "臣亮言：先帝創業未半，而中道崩殂。今天下三分，益州疲敝，此誠危急存亡之秋也！然侍衞之臣，不懈於內；忠志之士，忘身於外者，蓋追先帝之殊遇，欲報之於陛下也。誠宜開張聖聽，以光先帝遺德，恢弘志士之氣；不宜妄自菲薄，引喻失義，以塞忠諫之路也。宮中、府中，俱為一體；陟罰臧否，不宜異同。若有作奸、犯科，及為忠善者，宜付有司，論其刑賞，以昭陛下平明之治；不宜偏私，使內外異法也。"),
        Diary(name: "cat2", image: "cat2", date: "2021/07/03", isLike: false, description: "臣亮言：先帝創業未半，而中道崩殂。今天下三分，益州疲敝，此誠危急存亡之秋也！然侍衞之臣，不懈於內；忠志之士，忘身於外者，蓋追先帝之殊遇，欲報之於陛下也。誠宜開張聖聽，以光先帝遺德，恢弘志士之氣；不宜妄自菲薄，引喻失義，以塞忠諫之路也。宮中、府中，俱為一體；陟罰臧否，不宜異同。若有作奸、犯科，及為忠善者，宜付有司，論其刑賞，以昭陛下平明之治；不宜偏私，使內外異法也。"),
        Diary(name: "cat3", image: "cat3", date: "2021/07/04", isLike: false, description: "臣亮言：先帝創業未半，而中道崩殂。今天下三分，益州疲敝，此誠危急存亡之秋也！然侍衞之臣，不懈於內；忠志之士，忘身於外者，蓋追先帝之殊遇，欲報之於陛下也。誠宜開張聖聽，以光先帝遺德，恢弘志士之氣；不宜妄自菲薄，引喻失義，以塞忠諫之路也。宮中、府中，俱為一體；陟罰臧否，不宜異同。若有作奸、犯科，及為忠善者，宜付有司，論其刑賞，以昭陛下平明之治；不宜偏私，使內外異法也。"),
        Diary(name: "cat4", image: "cat4", date: "2021/07/05", isLike: false, description: "臣亮言：先帝創業未半，而中道崩殂。今天下三分，益州疲敝，此誠危急存亡之秋也！然侍衞之臣，不懈於內；忠志之士，忘身於外者，蓋追先帝之殊遇，欲報之於陛下也。誠宜開張聖聽，以光先帝遺德，恢弘志士之氣；不宜妄自菲薄，引喻失義，以塞忠諫之路也。宮中、府中，俱為一體；陟罰臧否，不宜異同。若有作奸、犯科，及為忠善者，宜付有司，論其刑賞，以昭陛下平明之治；不宜偏私，使內外異法也。"),
        Diary(name: "cat9", image: "cat9", date: "2021/07/06", isLike: false, description: "臣亮言：先帝創業未半，而中道崩殂。今天下三分，益州疲敝，此誠危急存亡之秋也！然侍衞之臣，不懈於內；忠志之士，忘身於外者，蓋追先帝之殊遇，欲報之於陛下也。誠宜開張聖聽，以光先帝遺德，恢弘志士之氣；不宜妄自菲薄，引喻失義，以塞忠諫之路也。宮中、府中，俱為一體；陟罰臧否，不宜異同。若有作奸、犯科，及為忠善者，宜付有司，論其刑賞，以昭陛下平明之治；不宜偏私，使內外異法也。")
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
        }
        
        navigationController?.hidesBarsOnSwipe = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diarys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diarycell", for: indexPath) as! DiaryTableViewCell
        cell.nameLabel.text = diarys[indexPath.row].name
        cell.dateLabel.text = diarys[indexPath.row].date
        cell.thumbnailImageVew.image = UIImage(named: diarys[indexPath.row].image)
        cell.heartImageView.isHidden = !self.diarys[indexPath.row].isLike

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.diarys.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Share my training plan: " + self.diarys[indexPath.row].name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.diarys[indexPath.row].image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else  {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        deleteAction.image = UIImage(systemName: "trash")
        shareAction.backgroundColor = UIColor.orange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        return swipeConfiguration
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let likeAction = UIContextualAction(style: .normal, title: "Like") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! DiaryTableViewCell
            self.diarys[indexPath.row].isLike = (self.diarys[indexPath.row].isLike) ? false : true
            cell.heartImageView.isHidden = self.diarys[indexPath.row].isLike ? false : true
            
            completionHandler(true)
        }
        
        let likeIcon = diarys[indexPath.row].isLike ? "arrow.uturn.left" : "heart.circle"
        likeAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        likeAction.image = UIImage(systemName: likeIcon)
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [likeAction])
        
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiaryDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DiaryDetailVC
                destinationController.diary = diarys[indexPath.row]
                
                
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }



    


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

}
