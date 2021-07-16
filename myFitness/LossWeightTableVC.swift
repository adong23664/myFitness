//
//  LossWeightTableVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/16.
//

import UIKit

class LossWeightTableVC: UITableViewController {
    
    var articleNames = ["7天年假，肚子肥一圈？運動醫師推薦「14天減重計畫」：小編實測1個月瘦超過7公斤", "瘦得美又不復胖！專業運管師4週瘦身計畫狂甩4公斤", "如何兩個月瘦十公斤？這是我的日常飲食與運動計畫", "減肥三餐怎麼吃才會瘦？營養師親授5大「不挨餓、不復胖」三餐飲食秘訣", "減重時常犯的9個錯誤，你中了幾個？", "這 13 個小技巧，讓超過 86% 人成功減肥不復胖"]
    
    var articleImageURLs = ["https://scontent.ftpe4-1.fna.fbcdn.net/v/t1.6435-9/218307640_3621878657914487_5547163269568425370_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=0debeb&_nc_ohc=Wbq9JM9myIMAX8ClEN1&_nc_ht=scontent.ftpe4-1.fna&oh=530312aa8addb1ce3f08a7ff48dbd901&oe=60F57C62", "https://scontent.ftpe4-1.fna.fbcdn.net/v/t1.6435-9/218205093_3621878621247824_556020925731562381_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=0debeb&_nc_ohc=eCeiLiaO-SwAX80jiBz&_nc_ht=scontent.ftpe4-1.fna&oh=783427bcd3c1a51627580c4f7b0ffb5a&oe=60F6E9FC", "https://scontent.ftpe4-1.fna.fbcdn.net/v/t1.6435-9/218308058_3621878674581152_2290745666668089402_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=0debeb&_nc_ohc=KS4RbA9ROiAAX_B4wmK&_nc_oc=AQnbBNsOEtjKH7-6yuYs79_ubXE3vkmts2rjp-TGSM1URTIYMQtpUvBMyZN5X5HNfcA&tn=XrslWOmswXjFRq4o&_nc_ht=scontent.ftpe4-1.fna&oh=87064543bba6fc672b1cf98da7f49e77&oe=60F630F0", "https://scontent.ftpe4-2.fna.fbcdn.net/v/t1.6435-9/219222392_3621878704581149_84400171069384537_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=0debeb&_nc_ohc=uGi7qAdiFBQAX9cBwKr&_nc_ht=scontent.ftpe4-2.fna&oh=c9688f5edcacb7eb18992ba2079e40dd&oe=60F5777F", "https://scontent.ftpe4-2.fna.fbcdn.net/v/t1.6435-9/218004093_3621878714581148_5910000610714049867_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=0debeb&_nc_ohc=6jLkTDg08pYAX_zQBcH&_nc_ht=scontent.ftpe4-2.fna&oh=8e7a4080e3026245464c694511a1d494&oe=60F5E103", "https://scontent.ftpe4-1.fna.fbcdn.net/v/t1.6435-9/218717320_3621878794581140_1079478479161638854_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=0debeb&_nc_ohc=zTtzPxn38y0AX-jrfGD&_nc_ht=scontent.ftpe4-1.fna&oh=84acc217df614db2e9f69fe2581fa44b&oe=60F62733"]
    
    var articleSources = ["今周刊", "早安健康", "Kyle Hsia", "BY ARIEL LIN 與 ALLEN CHANG", "BY ANA MORALES, SABRINA LEE", "營養百科團隊"]
    
    var articleAddresses = ["https://www.businesstoday.com.tw/article/category/183029/post/202102170010/7%E5%A4%A9%E5%B9%B4%E5%81%87%EF%BC%8C%E8%82%9A%E5%AD%90%E8%82%A5%E4%B8%80%E5%9C%88%EF%BC%9F%E9%81%8B%E5%8B%95%E9%86%AB%E5%B8%AB%E6%8E%A8%E8%96%A6%E3%80%8C14%E5%A4%A9%E6%B8%9B%E9%87%8D%E8%A8%88%E7%95%AB%E3%80%8D%EF%BC%9A%E5%B0%8F%E7%B7%A8%E5%AF%A6%E6%B8%AC1%E5%80%8B%E6%9C%88%E7%98%A6%E8%B6%85%E9%81%8E7%E5%85%AC%E6%96%A4", "https://www.edh.tw/article/23541", "https://www.thenewslens.com/article/136249", "https://www.harpersbazaar.com/tw/beauty/bodyandhealth/g27351797/healthy-nutrition-breakfast-lunch-dinner/", "https://www.vogue.com.tw/beauty/article/lose-weight-fast-mistakes", "https://blog.vitabox.com.tw/2017/08/%E9%80%99-13-%E5%80%8B%E5%B0%8F%E6%8A%80%E5%B7%A7%EF%BC%8C%E8%AE%93%E8%B6%85%E9%81%8E-86-%E4%BA%BA%E6%88%90%E5%8A%9F%E6%B8%9B%E8%82%A5%E4%B8%8D%E5%BE%A9%E8%83%96/"]
    
    

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "articlelosscell", for: indexPath)  as! ArticleLossTableViewCell
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
        if segue.identifier == "showLossArticle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ArticleLossDetailVC
                destinationController.articleWebURL = articleAddresses[indexPath.row]
            }
        }
    }

}
