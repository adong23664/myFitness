//
//  GetWeightTableVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/16.
//

import UIKit

class GetWeightTableVC: UITableViewController {
    
    var articleNames = ["最有效增重的方法： 給想健康增重者的究極指南","如何增重?吃不胖怎麼辦?","紙片人還在煩惱怎麼「增重」嗎?","身材過瘦沒肌肉？這 9 種食物能幫你健康增重！","【營養師工作觀察日誌】吃不胖！想增重該怎麼辦？","瘦≠健康！３招健康增重　讓你遠離死亡風險"]
    var articleImageURLs = ["https://scontent.ftpe4-1.fna.fbcdn.net/v/t1.6435-9/217256541_3621718491263837_1380899960510853709_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=0debeb&_nc_ohc=KbuIKEPC0IUAX_14D5b&_nc_ht=scontent.ftpe4-1.fna&oh=4d0230308f964217e92bb29782c5274b&oe=60F591BB", "https://scontent.ftpe4-1.fna.fbcdn.net/v/t1.6435-9/218321230_3621718561263830_3351675867120863493_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=0debeb&_nc_ohc=9uciz7HgxekAX_9sFMD&_nc_ht=scontent.ftpe4-1.fna&oh=493f3ea1bf2e8d5b914f13a668ff9213&oe=60F681DD", "https://scontent.ftpe4-2.fna.fbcdn.net/v/t1.6435-9/217674183_3621718517930501_8388670819851019334_n.jpg?_nc_cat=104&ccb=1-3&_nc_sid=0debeb&_nc_ohc=u5KHPW352vkAX8hii_T&tn=XrslWOmswXjFRq4o&_nc_ht=scontent.ftpe4-2.fna&oh=2814e60e5b8ad78c93b6b5236cbe6e6a&oe=60F61D98", "https://scontent.ftpe4-2.fna.fbcdn.net/v/t1.6435-9/218769367_3621718557930497_5630744581633977537_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=0debeb&_nc_ohc=UtEbkon5_XsAX_mz69f&_nc_ht=scontent.ftpe4-2.fna&oh=948c3cac9c01f1a701cfb1f7337dd21e&oe=60F706A5", "https://scontent.ftpe4-2.fna.fbcdn.net/v/t1.6435-9/218340800_3621718521263834_5171997895503919147_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=0debeb&_nc_ohc=10vjtI2-qe4AX8PHO8e&_nc_ht=scontent.ftpe4-2.fna&oh=043b536291db85141424bc8370c18232&oe=60F531E4", "https://scontent.ftpe4-2.fna.fbcdn.net/v/t1.6435-9/218379163_3621718477930505_9158086848282230556_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=0debeb&_nc_ohc=IfX058yA6MQAX-Zk9Mo&_nc_ht=scontent.ftpe4-2.fna&oh=e401522a29cc78803a9a5fb6393ba36b&oe=60F6F505"]
    
    var articleSources = ["台灣營養","Angela營養師","新食記運動","臺灣阿鹹","愛瘦身","健康"]
    
    var articleAddresses = ["https://www.taiwannutrition.com/blog/gain-weight-and-build-muscle-healthy/","https://angeladiet.com/gain-weight/","https://www.newtriday.com.tw/news-detail.php?sn=93","https://blog.icook.tw/posts/144259","https://www.i-fit.com.tw/context/1741.html","https://www.commonhealth.com.tw/article/78659"]
    

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
        return articleNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articlecell", for: indexPath) as! ArticleTableViewCell
        cell.nameLabel?.text = articleNames[indexPath.row]
        
        if let imageURL = URL(string: articleImageURLs[indexPath.row]){
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
        
        cell.sourceLabel?.text = articleSources[indexPath.row]
        
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddArticle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ArticleAddDetialVC
                destinationController.articleWebURL = articleAddresses[indexPath.row]
            }
        }
    }

}
